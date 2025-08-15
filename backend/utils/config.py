import os
from enum import Enum
import logging
from dotenv import load_dotenv
from typing import Dict, Any, Optional, get_type_hints, Union
from pydantic_settings import BaseSettings, SettingsConfigDict

logger = logging.getLogger(__name__)

class EnvMode(Enum):
    """ Environment Mode Enumurations """
    LOCAL = "local"
    DEVELOPMENT = "development"
    STAGING = "staging"
    PRODUCTION = "production"

class Settings(BaseSettings):
    EnvMode: EnvMode = EnvMode.LOCAL

    APP_NAME: str = "FastAPI Boilerplate"
    APP_VERSION: str = "0.0.1"