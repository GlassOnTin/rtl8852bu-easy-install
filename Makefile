# Makefile for RTL8852BU Easy Install

.PHONY: install check uninstall help

help:
	@echo "RTL8852BU Driver Installation Helper"
	@echo "===================================="
	@echo ""
	@echo "Available commands:"
	@echo "  make install   - Install the RTL8852BU driver"
	@echo "  make check     - Check driver status"
	@echo "  make uninstall - Remove the RTL8852BU driver"
	@echo "  make help      - Show this help message"
	@echo ""
	@echo "Example: make install"

install:
	@./rtl8852bu-installer.sh

check:
	@./check-rtl8852bu.sh

uninstall:
	@./uninstall-rtl8852bu.sh
