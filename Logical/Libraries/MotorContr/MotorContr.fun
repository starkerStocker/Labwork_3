
FUNCTION_BLOCK FB_Regulator (*Regulator functional block*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		e : REAL; (*Mismatch between the reference action and the real speed of rotation of the DCM shaft [rpm]*)
	END_VAR
	VAR_OUTPUT
		u : REAL; (*Voltage supplied to the DCM input [V]*)
	END_VAR
	VAR
		k_p : REAL; (*Regulator proportional gain*)
		k_i : REAL; (*Integral gain of the regulator*)
		integrator : FB_Integrator; (*Integrator*)
		iyOld : REAL; (*Storing the previous value of the anti-accumulation scheme*)
		max_abs_value : REAL; (*Limit block boundary [B]*)
		dt : REAL; (*Calculation step [s]*)
		e_p : REAL; (*Temporary variable [rpm]*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_Motor (*Motor functional block*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		u : REAL; (*Input voltage [V]*)
	END_VAR
	VAR_OUTPUT
		w : REAL; (*Rotation frequency [rpm]*)
		phi : REAL; (*Position [rad]*)
	END_VAR
	VAR
		integrator : FB_Integrator; (*Integrator*)
		Tm : REAL; (*Electromechanical time constant [s]*)
		ke : REAL; (*Constant EMF of the motor [V * min/rev]*)
		dt : REAL; (*Calculation step [s]*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_Integrator (*Integrator functional block*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		in : REAL; (*Integrator input*)
	END_VAR
	VAR_OUTPUT
		out : REAL; (*Integrator output*)
	END_VAR
	VAR
		dt : REAL; (*Calculation step [s]*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK FB_Axis (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		reset_error : {REDUND_UNREPLICABLE} BOOL;
		endswitch_a_reached : {REDUND_UNREPLICABLE} BOOL;
		endswitch_b_reached : {REDUND_UNREPLICABLE} BOOL;
	END_VAR
	VAR_OUTPUT
		reset_counter : {REDUND_UNREPLICABLE} BOOL;
		pwm_value : {REDUND_UNREPLICABLE} INT;
		counter : {REDUND_UNREPLICABLE} INT;
		speed : {REDUND_UNREPLICABLE} REAL;
	END_VAR
	VAR
		last_counter : {REDUND_UNREPLICABLE} INT;
		desired_speed : {REDUND_UNREPLICABLE} REAL;
		regulator : {REDUND_UNREPLICABLE} FB_Regulator;
		dt : REAL;
	END_VAR
	VAR_INPUT
		u : REAL;
	END_VAR
END_FUNCTION_BLOCK
