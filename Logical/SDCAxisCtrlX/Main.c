
#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

void _INIT ProgramInit(void)
{
	gAxis01_HW.EncIf1_Typ = ncSDC_ENC16;
	gAxis01_HW.DiDoIf_Typ = ncSDC_DIDO;
	gAxis01_HW.DrvIf_Typ = ncSDC_DRVSERVO16;

	gAxis_X_EncIf.iEncOK = 1;
	gAxis01_DrvIf.iDrvOK = 1;
	gAxis01_DrvIf.iStatusEnable = 1;
	gAxis01_DiDoIf.iDriveReady = 1;
	fb_controller.dt = 0.002;
	fb_controller.k_i = 0.16;
	fb_controller.k_p = 0.0064;
	fb_controller.max_abs_value = 24.0;
//	pwm_period = 200;
}

void _CYCLIC ProgramCyclic(void)
{
	if (!coil_powered) coil_pwm_value = 0;
	else coil_pwm_value = 32767;
	gAxis_X_EncIf.iLifeCnt++;
	gAxis01_DiDoIf.iLifeCntDriveEnable++;
	gAxis01_DiDoIf.iLifeCntDriveReady++;
	gAxis01_DiDoIf.iLifeCntNegHwEnd++;
	gAxis01_DiDoIf.iLifeCntPosHwEnd++;
	gAxis01_DiDoIf.iLifeCntReference++;
	gAxis01_DrvIf.iLifeCnt++;
	gAxis_X_EncIf.iActTime = (INT)AsIOTimeCyclicStart();
	gAxis_X_EncIf.iActPos = axis_X.counter;
	temp = gAxis01_DrvIf.oSetPos;
	fb_controller.e = (temp/32767.0)*6500.0 - axis_X.speed;
	FB_Regulator(&fb_controller);
	axis_X.u = fb_controller.u;
	gAxis01_DiDoIf.iPosHwEnd = axis_X.endswitch_b_reached;
	gAxis01_DiDoIf.iNegHwEnd = axis_X.endswitch_a_reached;
	if(axis_X.endswitch_a_reached) axis_X.reset_error = 1;
	if(axis_X.endswitch_b_reached) axis_X.reset_error = 1;
	axis_X.reset_error = 0;
}

void _EXIT ProgramExit(void)
{

}
