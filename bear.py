# draw an animal 
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
start_point = (90, 0)  # Start coordinates
p_1 = (88.6, -11.3)
p_2 = (86.8, -11.2)
p_3 = (84, -1.8)
p_4 = (71.2, 6.3)
p_5 = (60.15, -2.65)
p_6 = (66.6, -30)
p_7 = (54.4, -30.15)
p_8 = (53.3, -27.1)
p_9 = (57.1, -20.7)
p_10 = (46, 0)
p_11 = (39.6, 1)
p_12 = (37, 4.75) #(37, 4.8)
p_13 = (30.8, 6.45) #(32.1, 6)
p_14 = (26.05, 13.15) #(27.85, 11.9)
p_15 = (25.8, 21.75) #(27, 19.9)
p_16 = (23.6, 35)
p_17 = (26.2, 34.5)
p_18 = (21.6, 42.1)
p_19 = (24.1, 41.9)
p_20 = (28.3, 35.55)
p_21 = (24, 90)
p_22 = (53.8, 52.0)

end_point = (90, 0)  # End coordinates

# List of points to traverse in order
points = [start_point, 
    p_1, p_2, p_3, p_4, p_5, 
    p_6, p_7, p_8, p_9, p_10,
    p_11, p_15, p_12, p_13, p_14, 
    p_16, p_17, p_18, 
    p_19, p_20, p_21, p_22, 
    end_point
]
servo_0.write(90)
servo_1.write(0)
time.sleep(3)

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
