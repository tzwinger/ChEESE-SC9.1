-- Material parameters for ice

yearinsec=365.25*24*60*60
rhoi=917.0
rhow=1000.0
gravity=9.81
Eyoung=9.0e09
constvisc=1.0e11
-- ! * 1.0e-06 * yearinsec

-- Glen's exponent and inverse
n = 3.0
m = 1.0/n

-- rate factors and molar activiation energies
-- after Paterson 2010
A1 = 2.89165e-13
A2 = 2.42736e-02
Q1 = 60.0e3
Q2 = 115.0e3

Tc = -0.1
Arrh = 3.0E-24