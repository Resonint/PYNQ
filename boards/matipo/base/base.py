import pynq
from .constants import *


__author__ = "Cameron Dykstra"
__copyright__ = "Copyright 2022, Cameron Dykstra"
__email__ = "cameron@resonint.com"


class BaseOverlay(pynq.Overlay):
    """ The Base overlay for the Pynq-Z1

    This overlay is designed to interact with all of the on board peripherals
    and external interfaces of the matipo board. It exposes the following
    attributes:

    Attributes
    ----------

    """

    def __init__(self, bitfile, **kwargs):
        super().__init__(bitfile, **kwargs)
        if self.is_loaded():
            pass
