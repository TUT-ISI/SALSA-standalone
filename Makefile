PROG =	salsa

SRCS =	aerosol_thermodynamics.f90 class_componentIndex.f90 driver.f90 \
	mo_constants.f90 mo_kind.f90 mo_salsa.f90 mo_salsa_cloud.f90 \
	mo_salsa_driver.f90 mo_salsa_dynamics.f90 mo_salsa_init.f90 \
	mo_salsa_nucleation.f90 mo_salsa_properties.f90 mo_salsa_sizedist.f90 \
	mo_salsa_update.f90 mo_submctl.f90

OBJS =	aerosol_thermodynamics.o class_componentIndex.o driver.o \
	mo_constants.o mo_kind.o mo_salsa.o mo_salsa_cloud.o \
	mo_salsa_driver.o mo_salsa_dynamics.o mo_salsa_init.o \
	mo_salsa_nucleation.o mo_salsa_properties.o mo_salsa_sizedist.o \
	mo_salsa_update.o mo_submctl.o

LIBS =	

CC = cc
CFLAGS = -O
FC = gfortran
FFLAGS = -O
F90 = gfortran
F90FLAGS = -O
LDFLAGS = -s

all: $(PROG)

$(PROG): $(OBJS)
	$(F90) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)

clean:
	rm -f $(PROG) $(OBJS) *.mod *~

.SUFFIXES: $(SUFFIXES) .f90

%.o: %.f90
	$(F90) $(F90FLAGS) -c $<

aerosol_thermodynamics.o: mo_kind.o
class_componentIndex.o: 
driver.o: class_componentIndex.o mo_kind.o mo_salsa_cloud.o mo_salsa_driver.o \
	mo_salsa_init.o mo_salsa_sizedist.o mo_submctl.o
mo_constants.o: mo_kind.o
mo_kind.o: 
mo_salsa.o: class_componentIndex.o mo_kind.o mo_salsa_cloud.o \
	mo_salsa_dynamics.o mo_salsa_nucleation.o mo_salsa_properties.o \
	mo_salsa_update.o mo_submctl.o
mo_salsa_cloud.o: mo_constants.o mo_kind.o mo_submctl.o
mo_salsa_driver.o: class_componentIndex.o mo_kind.o mo_salsa.o \
	mo_salsa_properties.o mo_submctl.o
mo_salsa_dynamics.o: aerosol_thermodynamics.o class_componentIndex.o \
	mo_constants.o mo_kind.o mo_salsa_nucleation.o mo_salsa_properties.o \
	mo_submctl.o
mo_salsa_init.o: mo_kind.o mo_salsa_driver.o mo_submctl.o
mo_salsa_nucleation.o: mo_kind.o mo_submctl.o
mo_salsa_properties.o: mo_kind.o mo_submctl.o
mo_salsa_sizedist.o: mo_kind.o mo_salsa_driver.o mo_submctl.o
mo_salsa_update.o: mo_kind.o mo_submctl.o
mo_submctl.o: mo_kind.o
