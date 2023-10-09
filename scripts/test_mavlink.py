import time
import sys
from pymavlink import mavutil

# Create the connection
master = mavutil.mavlink_connection('/dev/ttyTHS1', baud=921600)

print('Waiting for heartbeat')
master.wait_heartbeat()
print('Found heartbeat')

# Request all parameters
master.mav.param_request_list_send(master.target_system,
                                   master.target_component)
while True:
    time.sleep(0.01)
    try:
        message = master.recv_match(type='PARAM_VALUE',
                                    blocking=True).to_dict()
        print('name: %s\tvalue: %d' %
              (message['param_id'], message['param_value']))
    except Exception as error:
        print(error)
        sys.exit(0)
