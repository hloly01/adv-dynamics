from servo import Servo
import time
from machine import I2C, Pin
import ssd1306

# Initialize servos
servo_0 = Servo(0, freq=200)  # Servo 0
servo_1 = Servo(1, freq=200)  # Servo 1

# Initialize display
i2c = I2C(scl=Pin(23), sda=Pin(22))
display = ssd1306.SSD1306_I2C(128, 64, i2c)

# Configuration
velocity = 100  # degrees/second
steps_per_segment = 50  # Number of steps per segment for smooth interpolation
wait_time = .05  # Time to wait at each position (in seconds)

# Define points
start_point = (0, 90)  # Start coordinates
step_1 = (38.6, -6.7)
step_2 = (0, 18)
step_3 = (39.1, -33)
step_4 = (0, -54)
step_5 = (72, -54)
# turn light off
#step_6 = (-72, 54)
#turn light on
#step_7 = (0, 54)
step_8 = (83.9, -33)
# step_7 = (38.6, -6.7)
# step_8 = (0, 18)
step_9 = (72, 18)
step_10 = (58.2, -6.7)
end_point = (0, 90)  # End coordinates

# List of points to traverse in order
time.sleep(3)
points = [start_point, step_1, step_2, step_3, step_4, step_5, step_8, step_9, step_10, end_point]
servo_0.write(0)
servo_1.write(90)
time.sleep(.2)

# Function to interpolate between two points
def interpolate(start, end, t):
    return start + t * (end - start)

# Function to display messages
def display_message(message):
    display.fill(0)  # Clear the display
    display.text(message, 0, 0, 1)  # Write the message
    display.show()  # Update the display

# Function to move servos smoothly between two points
def move_to_point(start, end, steps):
    for step in range(steps + 1):
        t = step / steps  # Normalized step (0 to 1)
        x = interpolate(start[0], end[0], t)
        y = interpolate(start[1], end[1], t)
        
        # Write the interpolated angles to the servos
        servo_0.write(x)
        servo_1.write(y)
        
        # Wait to maintain the desired velocity
        time.sleep(1 / velocity)

# Main movement loop through all points
for i in range(len(points) - 1):
    move_to_point(points[i], points[i + 1], steps_per_segment)
    message = f"{points[i + 1]}"  # Message to display
    display_message(message)  # Show message on the display
    time.sleep(wait_time)  # Wait at the current position

# Turn off the servos after completing the movement
servo_0.off()
servo_1.off()
display_message("Done!!")  # Final message
