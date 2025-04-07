import yaml
import time
from datetime import datetime
import subprocess
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Load the configuration file
def load_config():
    logging.info("Loading configuration file.")
    with open("/app/config.yml", "r") as file:
        return yaml.safe_load(file)

# Determine the current time period based on the hour
def get_current_time_period(config):
    current_hour = datetime.now().hour
    logging.debug(f"Current hour: {current_hour}")
    for period, details in config['time_periods'].items():
        if current_hour in details['hours']:
            logging.debug(f"Matched time period: {period}")
            return period
    logging.warning("No matching time period found.")
    return None

def main():
    logging.info("Starting time period monitor.")
    last_time_period = None

    while True:
        # Reload the configuration file on each iteration
        config = load_config()

        current_time_period = get_current_time_period(config)

        logging.info(f"Current time period: {current_time_period}, Last time period: {last_time_period}")

        if current_time_period != last_time_period:
            logging.info(f"Time period changed to: {current_time_period}")
            last_time_period = current_time_period

            # Execute the meloday.py script
            logging.info("Executing meloday.py script.")
            subprocess.run(["python", "/app/meloday.py"])

        logging.info("Sleeping for 10 minutes before checking again.")
        time.sleep(600)  # Check every 10 minutes

if __name__ == "__main__":
    main()