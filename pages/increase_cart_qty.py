#!/usr/bin/python3

import json
import os
import sys

#PACKAGE_PARENT = 
__SCRIPT_DIR = os.path.dirname(os.path.realpath(os.path.join(os.getcwd(), os.path.expanduser(__file__))))
__SCRIPT_DIR = os.path.normpath(os.path.join(__SCRIPT_DIR, '..'))
if not __SCRIPT_DIR in sys.path:
    sys.path.append(__SCRIPT_DIR)

from data.dao import Connection
from data.models import ShoppingCart
from utils import helpers, constants
from utils.helpers import FormParser, get_session_user_id, is_float

__ERRORS = {}

def __validate_properties(user_id, code, quantity):
    if not user_id or not is_float(user_id):
        __ERRORS[constants.VALIDATION_ERROR] = "El usuario no se ha autenticado."
    helpers.validate_string_input('code', code, constants.PRODUCT_CODE_LENGTH, 'Codigo', __ERRORS)
    if not quantity:
        __ERRORS['invalid_quantity'] = "Cantidad es requerida."
    elif  not is_float(quantity):
        __ERRORS['invalid_quantity'] = 'Cantidad debe ser un valor numérico'
    return __ERRORS

def __process_update_cart_qty():
    parser = FormParser()
    parser.discover_values()
    #validate session
    user_id = get_session_user_id()
    code = parser.get_value("code", "")
    quantity = parser.get_value("quantity", "")
    if __validate_properties(user_id, code, quantity):
        return False
    conn = Connection()
    product = conn.fetch_product_by_code(code)
    if not product:
        __ERRORS[constants.INVALID_CODE] = 'El producto no se encuentra registrado en el sistema.'
        return False
    if not conn.increase_cart_qty(ShoppingCart(user_id, product.product_id, quantity)):
        __ERRORS[constants.VALIDATION_ERROR] = conn.errors()
        return False
    return True

__RESULT = __process_update_cart_qty()
helpers.print_status_code(__RESULT, {}, __ERRORS)
