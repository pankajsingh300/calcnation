// Simple Node.js tests for finance.js
const assert = require('assert');
const Finance = require('../assets/js/finance.js');

console.log('Running finance module tests');

// mortgage
(function(){
  const data = Finance.calcMortgageValues(100000, 6, 30, 0);
  assert(data, 'mortgage returned data');
  // monthly should be about $599.55
  assert(Math.abs(data.monthly - 599.55) < 0.5, 'monthly payment approx 599.55');
  assert(data.total > data.principal, 'total payment greater than principal');
  console.log('🏠 mortgage tests passed');
})();

// EMI
(function(){
  const data = Finance.calcEMIValues(50000, 10, 60);
  assert(data, 'emi returned data');
  assert(Math.abs(data.emi - 1062) < 5, 'emi approx 1062');
  console.log('📋 EMI tests passed');
})();

// compound interest
(function(){
  const data = Finance.calcCompoundValues(10000, 100, 5, 10);
  assert(data, 'compound returned data');
  assert(data.totalContrib === 10000 + 100*120, 'total contributed');
  assert(data.roi > 0, 'ROI positive');
  console.log('📈 compound interest tests passed');
})();

// currency conversion tests
(function(){
  const conv = Finance.convertAmount(100, 'USD', 'EUR');
  assert(Math.abs(conv - 93) < 0.1, '100 USD -> ~93 EUR');
  const conv2 = Finance.convertAmount(50, 'EUR', 'USD');
  assert(Math.abs(conv2 - 50/0.93) < 0.2, 'EUR to USD conversion works');
  console.log('💱 currency conversion tests passed');
})();

// formatting helper (depends on global formatCurrency -> may not exist) 
console.log('All tests completed');
