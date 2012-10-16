
CHUGINS=ABSaturator Bitcrusher KasFilter MagicSine
CHUGS=$(foreach CHUG,$(CHUGINS),$(CHUG)/$(CHUG).chug)

INSTALL_DIR=/usr/lib/chuck

ifneq ($(CK_TARGET),)
.DEFAULT_GOAL:=$(CK_TARGET)
ifeq ($(MAKECMDGOALS),)
MAKECMDGOALS:=$(.DEFAULT_GOAL)
endif
endif

osx: $(CHUGS)
linux: $(CHUGS)
win32: $(CHUGS)

$(CHUGS): 
	make -C $(dir $@) $(MAKECMDGOALS)

clean:
	rm -rf $(addsuffix /*.o,$(CHUGINS)) $(CHUGS)

install: $(CHUGS)
	mkdir -p $(INSTALL_DIR)
	cp -rf $(CHUGS) $(INSTALL_DIR)

DATE=$(shell date +"%Y-%m-%d")
EXAMPLES=Bitcrusher/Bitcrusher-test.ck MagicSine/MagicSine-test.ck \
ABSaturator/ABSaturator-test.ck

bin-dist-osx: 
	make osx
	mkdir -p chugins-mac-$(DATE)/chugins/
	mkdir -p chugins-mac-$(DATE)/examples/
	cp -f notes/README-mac.txt chugins-mac-$(DATE)/
	cp -rf $(EXAMPLES) chugins-mac-$(DATE)/examples/
	cp -rf $(CHUGS) chugins-mac-$(DATE)/chugins/
	tar czf chugins-mac-$(DATE).tgz chugins-mac-$(DATE)
	rm -rf chugins-mac-$(DATE)/

bin-dist-win32: 
	mkdir -p chugins-windows-$(DATE)/chugins/
	mkdir -p chugins-windows-$(DATE)/examples/
	cp -f notes/README-windows.txt chugins-windows-$(DATE)/
	cp -rf $(EXAMPLES) chugins-windows-$(DATE)/examples/
	cp -rf $(CHUGS) chugins-windows-$(DATE)/chugins/
	tar czf chugins-windows-$(DATE).tgz chugins-windows-$(DATE)
	rm -rf chugins-windows-$(DATE)/

