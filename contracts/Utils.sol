// SPDX-License-Identifier: GPL-3.0
// pragma solidity >=0.7.0 <0.9.0;
pragma solidity ^0.8.0;

abstract contract Utils {
    enum EventType {
        created,
        changed
    }
    enum StructureType {
        customer,
        delivery,
        shop
    }
    event ChangeOwnership(uint256 id, address from, address to);
    event WithdrawBalance(
        uint256 id,
        StructureType _structure,
        uint256 amount,
        address to
    );
    address internal _owner;
    uint256 internal _balance;
    bool private _locked;
    // bool internal _paused;
    modifier NonReentrant() {
        require(!_locked, "RA");
        _locked = true;
        _;
        _locked = false;
    }

    // function Pausable() internal view {
    //     require(!_paused, "P");
    // }

    event Info(uint256 id, StructureType _structure, EventType _type);
}
