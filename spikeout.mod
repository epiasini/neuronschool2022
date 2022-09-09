:Spiking mechanism for a conductance-based integrate and fire neuron. Adapted from Brette et al 2007 (ModelDB#83319).
NEURON {
	POINT_PROCESS SpikeOut
	RANGE thresh, refrac, vreset, grefrac
	NONSPECIFIC_CURRENT i
}

PARAMETER {
	thresh = -45 (millivolt)
	refrac = 2.5 (ms)
	vreset = -75 (millivolt)
	grefrac = 100 (microsiemens) :clamp to vreset
}

ASSIGNED {
	i (nanoamp)
	v (millivolt)
	g (microsiemens)
}

INITIAL {
	net_send(0, 3)
	g = 0
}

BREAKPOINT {
	i = g*(v - vreset)
}

NET_RECEIVE(w) {
	if (flag == 1) {
		net_event(t)
		net_send(refrac, 2)
		v = vreset
		g = grefrac
	}else if (flag == 2) {
		g = 0
	}else if (flag == 3) {
		WATCH (v > thresh) 1
	}	
}






