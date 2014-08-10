ifeq ($(CONFIG_VITHAR_HWVER_R0P0),y)
obj-y			+= drm/ vga/ stub/ ion/
else
obj-y			+= drm/ vga/ stub/ ion/
endif

ifeq ($(CONFIG_MALI400),y)
ifeq ($(CONFIG_MALI_VER_R3P0),y)
obj-$(CONFIG_VIDEO_MALI400MP)	+= mali400/r3p0/mali/
obj-$(CONFIG_VIDEO_UMP)		+= mali400/r3p0/ump/
endif
endif

ifeq ($(CONFIG_MALI400),y)
ifeq ($(CONFIG_MALI_VER_R3P2),y)
obj-y           += mali400/r3p2/mali/
obj-y           += mali400/r3p2/ump/
endif
endif

ifeq ($(CONFIG_MALI400),y)
ifeq ($(CONFIG_MALI_VER_R4P0),y)
obj-y           += mali400/r4p0/mali/
obj-y           += mali400/r4p0/ump/
endif
endif
