// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第十六节：类库
 *
 */
library Calc {
    function add(uint a, uint b) internal pure returns (uint) {
        return a + b;
    }
}

library IdsArrays {
    function find(uint[] memory ids, uint v) internal pure returns (int) {
        for (uint n; n < ids.length; n++) {
            if (ids[n] == v) {
                return int(n);
            }
        }
        return -1;
    }
}

contract librarySectionEp16 {
    using Calc for uint;
    using IdsArrays for uint[];

    uint[] ids;

    function push(uint v) external {
        ids.push(v);
    }

    function find(uint v) external view returns (int) {
        return ids.find(v);
    }

    function sameple1(uint a) external pure returns (uint) {
        return Calc.add(a, 5);
    }

    function sameple2(uint a) external pure returns (uint) {
        return a.add(5);
    }
}
