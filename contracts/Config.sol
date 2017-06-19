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
	uint public initialProposalThreshold
	/// num votes needed to pass a reparameterization 
	uint public votesQuota;
	
	/// maps proposal hashes to corresponding vote tallies
	mapping(bytes32 => uint) public proposalMap;
}