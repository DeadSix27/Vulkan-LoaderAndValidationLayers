# top-level Linux makefile for
# https://github.com/KhronosGroup/Vulkan-LoaderAndValidationLayers
# mikew@lunarg.com

LVL_EXTERNAL_DIR = external

LVL_BUILD_DIR = BUILD
LVL_TESTS_DIR = $(LVL_BUILD_DIR)/tests

LVL_MAKEFILE = $(LVL_BUILD_DIR)/Makefile
LVL_TARGET = $(LVL_TESTS_DIR)/vk_layer_validation_tests

LVL_LAYER_PATH = $(PWD)/$(LVL_BUILD_DIR)/layers


all: $(LVL_TARGET)

$(LVL_EXTERNAL_DIR):
	./update_external_sources.sh

$(LVL_BUILD_DIR): $(LVL_EXTERNAL_DIR)
	mkdir $@

$(LVL_MAKEFILE) $(LVL_TESTS_DIR): $(LVL_BUILD_DIR)
	cd $(LVL_BUILD_DIR) && cmake ..

$(LVL_TARGET): $(LVL_MAKEFILE)
	cd $(LVL_BUILD_DIR) && $(MAKE)


t test tests: $(LVL_TARGET)
	cd $(LVL_TESTS_DIR) && VK_LAYER_PATH=$(LVL_LAYER_PATH) ./vk_layer_validation_tests


clean:
	echo TODO

clobber: clean
	-rm -rf $(LVL_BUILD_DIR)

nuke: clobber
	-rm -rf $(LVL_EXTERNAL_DIR)

# vim: set ts=8 noet ic ai:
