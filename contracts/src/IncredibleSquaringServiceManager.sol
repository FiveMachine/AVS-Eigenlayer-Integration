// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@eigenlayer/contracts/libraries/BytesLib.sol";
import "./IIncredibleSquaringTaskManager.sol";
import "@eigenlayer-middleware/src/ServiceManagerBase.sol";

/**
 * @title Primary entrypoint for procuring services from IncredibleSquaring.
 * @author Layr Labs, Inc.
 */
contract IncredibleSquaringServiceManager is ServiceManagerBase {
    using BytesLib for bytes;

    IIncredibleSquaringTaskManager
        public immutable incredibleSquaringTaskManager;

    /// @notice when applied to a function, ensures that the function is only callable by the `registryCoordinator`.
    modifier onlyIncredibleSquaringTaskManager() {
        require(
            msg.sender == address(incredibleSquaringTaskManager),
            "onlyIncredibleSquaringTaskManager: not from credible squaring task manager"
        );
        _;
    }

    constructor(
        IBLSRegistryCoordinatorWithIndices _registryCoordinator,
        ISlasher _slasher,
        IIncredibleSquaringTaskManager _incredibleSquaringTaskManager
    ) ServiceManagerBase(_registryCoordinator, _slasher) {
        incredibleSquaringTaskManager = _incredibleSquaringTaskManager;
    }

    /// @notice Called in the event of challenge resolution, in order to forward a call to the Slasher, which 'freezes' the `operator`.
    /// @dev The Slasher contract is under active development and its interface expected to change.
    ///      We recommend writing slashing logic without integrating with the Slasher at this point in time.
    function freezeOperator(
        address operatorAddr
    ) external override onlyIncredibleSquaringTaskManager {
        // require(
        //     msg.sender == address(???),
        //     "IncredibleSquaringServiceManager.freezeOperator: Only ??? can slash operators"
        // );
        // slasher.freezeOperator(operatorAddr);
    }
}
