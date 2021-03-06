#!/usr/bin/python3
"""Shows the page for create new products"""

import os
import sys

__SCRIPT_DIR = os.path.dirname(os.path.realpath(os.path.join(os.getcwd(), os.path.expanduser(__file__))))
__SCRIPT_DIR = os.path.normpath(os.path.join(__SCRIPT_DIR, '..'))
if not __SCRIPT_DIR in sys.path:
    sys.path.append(__SCRIPT_DIR)

from utils import constants, helpers

helpers.redirect_if_session_expired()

helpers.print_page("createproduct.html", "Crear nuevo producto", constants.DEFAULT_CSS, \
 '', '<script src="../js/create_product.js"></script>', True)
