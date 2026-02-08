#!/usr/bin/env python3
"""
Busca hilos abiertos hoy en burbuja.info y los abre en el navegador.

Uso:
    ~/burbuja.info/hilos_hoy.py              # Lista y abre hilos de hoy
    ~/burbuja.info/hilos_hoy.py --dry-run    # Solo lista, no abre navegador
    ~/burbuja.info/hilos_hoy.py --all        # Muestra todos los hilos recientes
"""

import argparse
import re
import subprocess
import sys
import urllib.request
from datetime import datetime

import lxml.html

# --- Configuración ---

BASE_URL = "https://www.burbuja.info/inmobiliaria/forums/-/list?order=start_date&direction=desc&page={page}"

COOKIES = (
    "xf_user=194363%2Ci7WQCjNWzMniIPpWgJs3JePSlgr9bmrxOvLkBUUb; "
    "cf_clearance=7HXo.meSFLQ78V7Au2BexBlmP7TXChh5roWZmSyso-1770572893-1.2.1.1-JyU8Mah5IO2XMOep_uVDWIfAu0IcQGsUNfgNSk6WXvQfO.nIQrIg9KEchxxD91gucMIXxucMHD9WrFBUAcvP74NUPOSCNfseYQINcLuuLfggCMB.RmTkc19862paQlHl9y4wRVbEce1Z4XTKnljOma0Onu4fRoFIhIT1cbSipuhIXtu5yhlRnFsluaPWwrXzrGysm7esFboVS45XYzMrCN1CZDP_Ay5WzATdrc6NlKQ"
)

USER_AGENT = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"

MAX_PAGES = 50


# --- Funciones ---

def fetch_page(url):
    """Descarga una URL con las cookies y User-Agent configurados."""
    req = urllib.request.Request(url, headers={
        "Cookie": COOKIES,
        "User-Agent": USER_AGENT,
    })
    with urllib.request.urlopen(req, timeout=15) as resp:
        return resp.read().decode("utf-8", errors="replace")


_ID_RE = re.compile(r'/temas/(\d+)')


def parse_threads(page_html, today):
    """
    Extrae hilos de una página HTML usando XPath.
    Devuelve (threads, found_old) donde found_old indica si hay hilos anteriores a hoy.
    """
    tree = lxml.html.fromstring(page_html)
    threads = []
    found_old = False

    # Cada hilo está en un .block-row que contiene un enlace a /temas/ y un <time>
    for row in tree.xpath('//*[contains(@class, "block-row")]'):
        link = row.xpath('.//a[contains(@href, "/inmobiliaria/temas/")]')
        time_elem = row.xpath('.//time[@datetime]')
        if not link or not time_elem:
            continue

        link = link[0]
        time_elem = time_elem[0]

        href = link.get("href", "")
        title = link.text_content().strip()
        if not title or len(title) < 3:
            continue

        m = _ID_RE.search(href)
        if not m:
            continue
        thread_id = int(m.group(1))

        dt_str = time_elem.get("datetime", "")
        time_text = time_elem.text_content().strip()
        date_part = dt_str[:10]

        if date_part < today:
            found_old = True
            continue
        if date_part != today:
            continue

        # Limpiar URL
        clean = href.split("/post-")[0].replace("/unread", "")
        if not clean.endswith("/"):
            clean += "/"
        full_url = f"https://www.burbuja.info{clean}"

        threads.append({
            "id": thread_id,
            "title": title,
            "url": full_url,
            "datetime": dt_str,
            "time_text": time_text,
        })

    return threads, found_old


def open_in_browser(urls):
    """Abre URLs en el navegador (wslview para WSL, xdg-open como fallback)."""
    opener = None
    for cmd in ("wslview", "xdg-open"):
        try:
            subprocess.run([cmd, "--help"], capture_output=True, timeout=2)
            opener = cmd
            break
        except (FileNotFoundError, subprocess.TimeoutExpired):
            continue

    if not opener:
        print("No se encontró navegador (wslview/xdg-open)", file=sys.stderr)
        return

    for url in urls:
        subprocess.Popen([opener, url], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


def main():
    parser = argparse.ArgumentParser(description="Hilos de hoy en burbuja.info")
    parser.add_argument("--all", action="store_true", help="Mostrar todos los hilos recientes, no solo los de hoy")
    parser.add_argument("--dry-run", action="store_true", help="Solo listar, no abrir navegador")
    parser.add_argument("--pages", type=int, default=MAX_PAGES, help=f"Páginas máximas (default: {MAX_PAGES})")
    parser.add_argument("--json", action="store_true", help="Salida en JSON")
    args = parser.parse_args()

    today = datetime.now().strftime("%Y-%m-%d")
    all_threads = {}
    max_id = 0

    for page in range(1, args.pages + 1):
        url = BASE_URL.format(page=page)
        try:
            page_html = fetch_page(url)
        except Exception as e:
            print(f"Error página {page}: {e}", file=sys.stderr)
            break

        threads, found_old = parse_threads(page_html, today)

        for t in threads:
            tid = t["id"]
            if tid > max_id:
                max_id = tid
            all_threads[tid] = t

        if not args.all and found_old:
            break

        if args.all and page >= 5:
            break

    # Filtrar bumpeados: solo IDs dentro de 1000 del máximo
    if max_id > 0 and not args.all:
        min_id = max_id - 1000
        all_threads = {k: v for k, v in all_threads.items() if k >= min_id}

    result = sorted(all_threads.values(), key=lambda x: x["id"], reverse=True)

    if args.json:
        import json
        print(json.dumps(result, ensure_ascii=False, indent=2))
        return

    today_fmt = datetime.now().strftime("%d/%m/%Y")
    label = "Hilos recientes" if args.all else f"Hilos de hoy ({today_fmt})"
    print(f"\n{label}: {len(result)} encontrados\n")

    for i, t in enumerate(result, 1):
        print(f"  {i:3d}. {t['title']}")
        print(f"       {t['url']}")

    if not result:
        print("  (ninguno)")
        return

    if not args.dry_run:
        urls = [t["url"] for t in result]
        print(f"\nAbriendo {len(urls)} hilos en el navegador...")
        open_in_browser(urls)
    else:
        print(f"\n(--dry-run: no se abre navegador)")


if __name__ == "__main__":
    main()
