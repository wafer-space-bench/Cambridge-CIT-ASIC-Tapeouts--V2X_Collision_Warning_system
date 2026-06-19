# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Starting V2V Collision Warning Test")

    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    await ClockCycles(dut.clk, 10)

    dut.rst_n.value = 1

    # Test Case 1
    dut.ui_in.value = 50
    dut.uio_in.value = 55
    await ClockCycles(dut.clk, 1)
    assert int(dut.uo_out.value) == 1, \
        "Failed: Distance=5 should generate warning"

    # Test Case 2
    dut.ui_in.value = 20
    dut.uio_in.value = 40
    await ClockCycles(dut.clk, 1)
    assert int(dut.uo_out.value) == 0, \
        "Failed: Distance=20 should not generate warning"

    # Test Case 3
    dut.ui_in.value = 100
    dut.uio_in.value = 108
    await ClockCycles(dut.clk, 1)
    assert int(dut.uo_out.value) == 1, \
        "Failed: Distance=8 should generate warning"

    # Test Case 4
    dut.ui_in.value = 20
    dut.uio_in.value = 30
    await ClockCycles(dut.clk, 1)
    assert int(dut.uo_out.value) == 0, \
        "Failed: Distance=10 should not generate warning"

    # Test Case 5
    dut.ui_in.value = 80
    dut.uio_in.value = 80
    await ClockCycles(dut.clk, 1)
    assert int(dut.uo_out.value) == 1, \
        "Failed: Distance=0 should generate warning"

    dut._log.info("All V2V tests passed!")
