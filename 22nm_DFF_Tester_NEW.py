#! /usr/bin/python
############################################################
'''
Created by Christopher Elash in September 2021

This test program is meant for the 22nm FDSOI test chip and will test the chips 
DFF .

Please read any further documentation provided with this code to gain a better of understanding of how it works.
Also ensure that the FPGA and testboard are properly set up before running this test.
'''
############################################################

CLOCK_PERIOD = 0.000001  # The period for the clocking of the system. Seems stable at 1 MHz

import time
import RPi.GPIO as GPIO
import sys

# Setup for all the GPIO pins

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BOARD) # use the actual pin number 
GPIO.setup(7, GPIO.OUT, initial = GPIO.LOW) # the save pin for collecting the error registers (posedge)
GPIO.setup(8, GPIO.OUT, initial = GPIO.LOW) # the data clk to get the counter data from the dffs
GPIO.setup(10, GPIO.IN) # the data out for the counters of the dff

"""
Converts a binary numbary to an equivlant decimal.

n: a number in binary

Returns: nothing
"""  
def binaryToDecimal(n):
    return int(n,2)



"""
Takes in a number in seconds and outputs array of days, hours, minutes, and seconds

n: a number in seconds

Returns: array of days, hours, minutes, and seconds elapsed
"""  
def timeElapsed(seconds):
    time_elapsed = [0, 0, 0, 0]
    
    seconds_in_day = 60*60*24
    seconds_in_hour = 60*60
    seconds_in_minute = 60
    
    
    days = seconds // seconds_in_day
    hours = (seconds -  (days*seconds_in_day)) // seconds_in_hour
    minutes = (seconds - (days * seconds_in_day) - (hours*seconds_in_hour)) // seconds_in_minute
    seconds_remaining = int(seconds % 60)
    
    time_elapsed = [days, hours, minutes, seconds_remaining]
    return time_elapsed


"""
Sends a clock pulse to the RO data out clk

Returns: nothing
"""
def clockDataDFF():
    GPIO.output(8, GPIO.HIGH)
    time.sleep(CLOCK_PERIOD)
    GPIO.output(8, GPIO.LOW)
    time.sleep(CLOCK_PERIOD)


"""
Returns a list containing the frequencies of the ROs in MHz.
0 - Inverter
1 - NAND
2 - NOR

Returns: list of frequencies for the ROs
"""
def getDFFData():

    # variables for error count
    error_count = 0
    

    # to hold the 32 bits for each counter
    error_count_bits = ''
    

    #read the counter for the chain of 32 bits
    for i in range(32):
        clockDataDFF() # clock the next bit in
        if (GPIO.input(10)):
            error_count_bits = '1' + error_count_bits
        else:
            error_count_bits = '0' + error_count_bits
        
    
    # now convert from binary to int
    error_count = int(error_count_bits, 2)


    return error_count



if __name__ == '__main__':

    # open up files to save the test data with start time in name
    StartTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
    StartTime_File = str(StartTime).replace(':','-')
    dff_file = open("/home/pi/Desktop/%s-DFF_Test.txt" %(StartTime_File),"w")
    
    time_elapsed_start = time.time()


    
    GPIO.setwarnings(False)
    time.sleep(0.5)
    print("               _____  ______ ______           ")
    print("              |  __ \|  ____|  ____|          ")
    print("              | |  | | |__  | |__             ")
    print("              | |  | |  __| |  __|            ")
    print("              | |__| | |    | |               ")
    print("  _______ ____|_____/|_|____|_| ______ _____  ")
    print(" |__   __|  ____|/ ____|__   __|  ____|  __ \ ")
    print("    | |  | |__  | (___    | |  | |__  | |__) |")
    print("    | |  |  __|  \___ \   | |  |  __| |  _  / ")
    print("    | |  | |____ ____) |  | |  | |____| | \ \ ")
    print("    |_|  |______|_____/   |_|  |______|_|  \_\\")
    print("                                              ")
    print("                                              ")
    print("                                              ")
    time.sleep(0.5)
    print("Welcome to the 22nm FDSOI DFF Teseter\n")
    print ("Press 'CTRL+C' when done testing to terminate")
    time.sleep(1)

    #show the local time
    StartTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
    print("The beginning time: ", StartTime)
    data_string_write = "The beginning time: " + StartTime + "\n"
    dff_file.write(data_string_write)

    time.sleep(0.5)

    print("Beginning to read results")

    while True:
        try:

            # now do the testing for the ROs
            output_chains = []
            
            # first save the counter data
            GPIO.output(7, GPIO.HIGH) # reset signal
            time.sleep(CLOCK_PERIOD)
            GPIO.output(7, GPIO.LOW)

            for i in range(14): # 14 chains
            
                

                error_count_chain = getDFFData()

                output_chains.append(error_count_chain)
                
            # now print out and log the data
                

            # nor frequency
            CurrentTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
            data_string_print = CurrentTime + ' ' + str(output_chains)
            data_string_write = CurrentTime + ' ' + str(output_chains) + "\n"
            print(data_string_print)
            dff_file.write(data_string_write)
            
            # time elapsed
            time_elapsed_now = time.time() - time_elapsed_start
            elapsed = timeElapsed(time_elapsed_now)
            CurrentTime = time.strftime("%Y_%m_%d_%H:%M:%S", time.gmtime())
            data_string_print = CurrentTime + " Time Elapsed: " + str(elapsed[0]) + "d " + str(elapsed[1]) + "h " + str(elapsed[2]) + "m " + str(elapsed[3]) + "s "
            data_string_write = CurrentTime + " Time Elapsed: " + str(elapsed[0]) + "d " + str(elapsed[1]) + "h " + str(elapsed[2]) + "m " + str(elapsed[3]) + "s " + "\n"
            #print(data_string_print)
            #dff_file.write(data_string_write)

            #print("\n")
            time.sleep(0.5)


        except KeyboardInterrupt:   # if user presses CTRL+C end the testing
            print("Ending Testing")
            dff_file.close()
            sys.exit()