contract Config {
	/// application & challenger deposit amounts
	uint public minDeposit; 
	/// duration of the challenge period
	uint public challengeDuration;
	/// duration of a registration’s validity
	uint public registryDuration;
	/// duration of the commit period in token votes
	uint public commitVoteDuration;
	/// duration of reveal period in token votes 
	uint public revealVoteDuration;
	/// percentage of forfeited deposit distributed to winning party
	uint public dispensationRatio;

	/// share of tokens required to initiate a reparameterization
	uint public initProposalThreshold;
	/// num votes needed to pass a reparameterization 
	uint public votesQuota;

	StandardToken public token;

	struct Proposal {
		uint voteTally;
		uint expirationBlock;
	}

	/// maps proposal hashes to corresponding vote tallies
	mapping(bytes32 => Proposal) public proposalMap;

	modifier validProposer {
		require(token.balanceOf(msg.sender) > initProposalThreshold);
		_;
	}

	function Config(
		uint _minDeposit,
		uint _challengeDuration,
		uint _registryDuration,
		uint _commitVoteDuration,
		uint _revealVoteDuration,
		uint _dispensationRatio,
		uint _initialProposalThreshold,
		uint _votesQuota,
		address tokenAddr,
		address voteTokenAddr
	) {
		minDeposit 			= _minDeposit; 
		challengeDuration 	= _challengeDuration;
		registryDuration 	= _registryDuration;
		commitVoteDuration 	= _commitVoteDuration;
		revealVoteDuration 	= _revealVoteDuration;
		dispensationRatio 	= _dispensationRatio;
		initProposalThreshold = _initialProposalThreshold;
		votesQuota 			= _votesQuota;

		token = StandardToken(tokenAddr);
		voteToken = StandardToken(voteTokenAddr);
	}

	function propose(string proposalData) {
		proposeHash(sha3(proposalData));
	}

	function proposeHash(bytes32 proposalHash) validProposer {
		proposalMap[proposalHash] = Proposal(
			voteToken.balanceOf(msg.sender),  //initial votes
			block.number + commitVoteDuration //expirationBlock
		);
	}
}