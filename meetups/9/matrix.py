# -*- coding: utf-8 -*-

from __future__ import division
import matplotlib.pyplot as plt

import math
import numpy as np
import numpy as np
import matplotlib.cm as cm
import matplotlib.mlab as mlab
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.cm as cm
import  matplotlib.pyplot as plt

step = 10
Lat_st_deg = 30
Lat_st = Lat_st_deg*2*math.pi/360
Lat_f_deg = 42
Lat_f = Lat_f_deg*2*math.pi/360
slope_deg =20
slope = slope_deg * 2*math.pi/360
rot_g_deg = 20
rot_g =rot_g_deg * 2*math.pi/360

input_data = [] # Στον πίνακα Α αποθηκεύονται τα στοιχεία από το input

# Εισαγωγή δεδομένων
fi = open('input')
input = [] # Στον πίνακα input αποθηκεύονται τα raw στοιχεία
counter = 0
while True:
	line = fi.readline()
	if line =='':	
		break
	input.append(line)
	counter = counter + 1
fi.close()
print 'counter = ', counter
matr = np.zeros((counter, 15))
matr_total = np.zeros((19, 37))

# population του πίνακα input_data
for i in input:
	y = [x for x in eval(i)]	
	input_data.append(y)

for i in range(0,len(input_data)):
	for j in range(0,len(input_data[i])):
		matr[i][j] = input_data[i][j]

for i in range(0,(matr.shape)[0]):
	# B (rad)
	matr[i][4] = ((matr[i][0]-81)/364*360)/360*2*math.pi
	# E
	matr[i][5] = 9.87*math.sin(2*matr[i][4])-7.53*math.cos(matr[i][4])-\
	1.5*math.sin(matr[i][4])
	# dt
	matr[i][6] = int(4*(Lat_st_deg-Lat_f_deg)+matr[i][5])
	# solar time
	if matr[i][3]+matr[i][6]<1440:
		matr[i][7] = matr[i][3]+matr[i][6]
	else:
		matr[i][7] = matr[i][3]+matr[i][6] - 1440
	# δ
	matr[i][8] = 23.45*math.sin(math.pi/180*360*(284+matr[i][0])/365)*2*math.pi/360
	# ω
	matr[i][9] = ((matr[i][7]-720)/60*15)*2*math.pi/360

for slope_deg in range(0,95,5):
	slope = slope_deg * 2*math.pi/360
	for rot_g_deg in range(-90,95,5):	
		rot_g =(rot_g_deg-0) * 2*math.pi/360		
		for i in range(0,(matr.shape)[0]):
			matr[i][10] = math.sin(matr[i][8]) * math.sin(Lat_f) * math.cos(slope)-\
			math.sin(matr[i][8]) * math.cos(Lat_f) * math.sin(slope) * math.cos(rot_g)+\
			math.cos(matr[i][8]) * math.cos(Lat_f) * math.cos(slope) * math.cos(matr[i][9])	+\
			math.cos(matr[i][8]) * math.sin(Lat_f) * math.sin(slope) * math.cos(rot_g) * math.cos(matr[i][9])+\
			math.cos(matr[i][8]) * math.sin(slope) * math.sin(rot_g) * math.sin(matr[i][9])	
			# Watt
			if matr[i][10]>0:
				matr[i][11] = matr[i][10]*math.cos(matr[i][9])*matr[i][1]
			else:
				matr[i][11] = 0
				
			matr_total[int(slope_deg/5)][int(rot_g_deg/5)+18] = matr.T[11].sum()/1000
		print 'slope = ', slope_deg, 'rotation = ', rot_g_deg, 'kWh/year = ', matr.T[11].sum()/1000 