STD=standard
VSTD=08
ENTITY=tb_mux
RUN_OPTIONS= --unbuffered --stop-time=5000ns --wave=${ENTITY}.ghw 
GHDLFLAGS=--std=$(VSTD) --workdir=build -Pbuild
HM=hdl-modules/modules

SOURCES_HM = \
 common:${HM}/common/src/types_pkg.vhd \
 common:${HM}/common/src/common_pkg.vhd \
 math:${HM}/math/src/math_pkg.vhd \
 common:${HM}/common/src/addr_pkg.vhd \
 axi_lite:${HM}/axi_lite/src/axi_lite_pkg.vhd \
 axi_lite:${HM}/axi_lite/src/axi_lite_mux.vhd

SOURCES = hdl/dummy_axil_slave.vhd

.PHONY: all deps clean

all: ${ENTITY}

deps:
	mkdir -p build
	for s in ${SOURCES_HM}; do ghdl -a ${GHDLFLAGS} --work=$${s%%:*} $${s#*:} || exit 1; done

${ENTITY}: deps
	ghdl -a ${GHDLFLAGS} ${SOURCES}
	ghdl -e ${GHDLFLAGS} ${ENTITY}
	ghdl -r ${GHDLFLAGS} ${ENTITY} ${RUN_OPTIONS}

check: deps
	ghdl -a ${GHDLFLAGS} ${SOURCES}

clean: 
	rm -rf build