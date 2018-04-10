    module classes
    use precision
    implicit none

    Type MatterTransferData
        !Computed data
        integer   ::  num_q_trans   !    number of steps in k for transfer calculation
        real(dl), dimension (:), allocatable :: q_trans
        real(dl), dimension (:,:), allocatable ::  sigma_8
        real(dl), dimension (:,:), allocatable ::  sigma2_vdelta_8  !growth from sigma_{v delta}
        real, dimension(:,:,:), allocatable :: TransferData
        !Sources
        real(dl), dimension(:), allocatable :: optical_depths
        !TransferData(entry,k_index,z_index) for entry=Tranfer_kh.. Transfer_tot
    end Type MatterTransferData

    Type MatterPowerData
        !everything is a function of k/h
        integer   ::  num_k, num_z
        real(dl), dimension(:), allocatable :: log_kh, redshifts
        !matpower is log(P_k)
        real(dl), dimension(:,:), allocatable :: matpower, ddmat
        !if NonLinear, nonlin_ratio =  sqrt(P_nonlinear/P_linear)
        !function of k and redshift NonLinearScaling(k_index,z_index)
        real(dl), dimension(:,:), allocatable :: nonlin_ratio
        !Sources
        real(dl), dimension(:), allocatable :: log_k
        real(dl), dimension(:,:), allocatable :: vvpower, ddvvpower
        real(dl), dimension(:,:), allocatable :: vdpower, ddvdpower

        real(dl), dimension(:,:), allocatable :: nonlin_ratio_vv
        real(dl), dimension(:,:), allocatable :: nonlin_ratio_vd
    end Type MatterPowerData

    type TCambComponent
    contains
    procedure :: ReadParams => TCambComponent_ReadParams
    end type TCambComponent

    type, extends(TCambComponent) :: TNonLinearModel
        integer :: Min_kh_nonlinear  = 0.005
    contains
    procedure :: GetNonLinRatios => TNonLinearModel_GetNonLinRatios
    procedure :: GetNonLinRatios_All => TNonLinearModel_GetNonLinRatios_All
    end type

    contains

    subroutine TCambComponent_ReadParams(this, Ini)
    use IniObjects
    class(TCambComponent), intent(inout) :: this
    class(TIniFile), intent(in) :: Ini

    end subroutine TCambComponent_ReadParams

    subroutine TNonLinearModel_GetNonLinRatios(this,CAMB_Pk)
    class(TNonLinearModel) :: this
    type(MatterPowerData) :: CAMB_Pk
    error stop 'GetNonLinRatios Not implemented'
    end subroutine TNonLinearModel_GetNonLinRatios

   subroutine TNonLinearModel_GetNonLinRatios_All(this,CAMB_Pk)
    class(TNonLinearModel) :: this
    type(MatterPowerData) :: CAMB_Pk
    error stop 'GetNonLinRatios_all  not supported (no non-linear velocities)'
   end subroutine TNonLinearModel_GetNonLinRatios_All
   
    end module classes