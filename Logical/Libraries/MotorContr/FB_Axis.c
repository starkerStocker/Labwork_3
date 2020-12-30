
#include <bur/plctypes.h>
#ifdef __cplusplus
	extern "C"
	{
#endif
	#include "MotorContr.h"
#ifdef __cplusplus
	};
#endif
void FB_Axis(struct FB_Axis* inst)
{
	inst->pwm_value = (inst->u/24)*32767;
	inst->speed = ((REAL)inst->counter - (REAL)inst->last_counter)*3000/(24.0*inst->dt); //counter - last_counter
	inst->last_counter=inst->counter;
}


