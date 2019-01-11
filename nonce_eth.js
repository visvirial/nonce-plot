
const async = require('async');
const Web3 = require('web3');

if(process.argv.length < 3) {
	console.log('uasge: node ./nonce_eth.js START_BLOCK');
	process.exit(1);
}

const START_BLOCK = +process.argv[2];

const web3 = new Web3('ws://localhost:8546');

web3.eth.isSyncing().then((syncing) => {
	let i = START_BLOCK;
	async.whilst(() => i<=syncing.currentBlock, (cb) => {
		web3.eth.getBlock(i).then((block) => {
			console.log(i + ',' + web3.utils.hexToNumberString(block.nonce));
			i++;
			cb();
		});
	}, () => process.exit(0));
});

