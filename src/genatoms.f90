program genatoms
  implicit none
  
  integer, parameter :: dp = selected_real_kind(15,300)

  type axis
     ! number of atoms along axis
     integer  :: numatm
     
     ! maximum position of atom along axis
     real(dp) :: maxpos
     
     ! distance between atoms along axis
     ! doesn't matter what the default is, as long as there is one
     real(dp) :: step=0.0_dp
  end type axis

  type(axis) :: axes(3)
  
  integer  :: intercase
  character(2) :: intertype(2,4,2) = 'Mg'

  integer  :: purelines = 2

  integer  :: i, j, k
  real(dp) :: xc,yc,zc

  10 format (4x,a2,3(4x,f12.10))

  read *, intercase

  axes(1) = axis(2, 1.0_dp)
  axes(2) = axis(2, 1.0_dp)
  axes(3) = axis(2, 1.0_dp)

  select case (intercase)
     case(1)
     case(2)
        intertype(1,1,2)  = 'Ca'
     case(3)
        intertype(1:2,1,2) = 'Ca'
     case(4)
        intertype(1,1:2,2) = 'Ca'
     case(5)
        intertype(1,1:3,2) = 'Ca'
     case(6)
        intertype(1,1:4,2) = 'Ca'
     case(7)
        intertype(1,1:4,2) = 'Ca'
        intertype(2,1,2)   = 'Ca'
     case(8)
        intertype(1,1:4,2) = 'Ca'
        intertype(2,1:2,2) = 'Ca'
     case(9)
        intertype(1,1:4,2) = 'Ca'
        intertype(2,1:3,2) = 'Ca'
     case(10)
        intertype(1:2,1:4,2) = 'Ca'
     case(11)
        intertype(1:2,1:4,2) = 'Ca'
        intertype(1,1,1)     = 'Ca'
     case default
        stop "ERROR"
  end select

  where (axes(:)%numatm /= 1) axes(:)%step = axes(:)%maxpos / (axes(:)%numatm-1)

  xc = 0.0_dp
  yc = 0.0_dp
  zc = 0.0_dp

  ! upper layer
  do k=1,purelines
     do j=1,axes(2)%numatm
        do i=1,axes(1)%numatm
           write(*,10) 'Mg', xc, yc, zc
           xc = xc + axes(1)%step
        end do
        xc = 0.0_dp
        yc = yc + axes(2)%step
     end do
     yc = 0.0_dp
     zc = zc + axes(3)%step
  end do

  ! middle layer
  do k=1,axes(3)%numatm-2*purelines
     do j=1,axes(2)%numatm
        do i=1,axes(1)%numatm
           write(*,10) 'Mg', xc, yc, zc
           xc = xc + axes(1)%step
        end do
        xc = 0.0_dp
        yc = yc + axes(2)%step
     end do
     yc = 0.0_dp
     zc = zc + axes(3)%step
  end do

  ! bottom layer
  do k=1,purelines
     do j=1,axes(2)%numatm
        do i=1,axes(1)%numatm
           write(*,10) 'Ca', xc, yc, zc
           xc = xc + axes(1)%step
        end do
        xc = 0.0_dp
        yc = yc + axes(2)%step
     end do
     yc = 0.0_dp
     zc = zc + axes(3)%step
  end do

end program
