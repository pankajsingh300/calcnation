// Shared finance calculators and helpers

function calcMortgageValues(principal, ratePct, years, down) {
  const P = Math.max(0, principal - (down || 0));
  const r = (ratePct || 0) / 100 / 12;
  const n = (years || 30) * 12;
  if (!P || n <= 0) {
    return null;
  }
  const M = r === 0 ? P / n : P * r * Math.pow(1 + r, n) / (Math.pow(1 + r, n) - 1);
  const total = M * n;
  const totalInt = total - P;
  const payoffYear = new Date().getFullYear() + n / 12;
  return { monthly: M, total, totalInt, payoffYear, periods: n, principal: P, rate: r };
}

function calcEMIValues(principal, ratePct, months) {
  const P = principal || 0;
  const r = (ratePct || 0) / 100 / 12;
  const n = months || 0;
  if (!P || n <= 0) return null;
  const emi = r === 0 ? P / n : P * r * Math.pow(1 + r, n) / (Math.pow(1 + r, n) - 1);
  const total = emi * n;
  const totalInt = total - P;
  return { emi, total, totalInt, principal: P };
}

function calcCompoundValues(principal, monthly, ratePct, years) {
  const P = principal || 0;
  const pm = monthly || 0;
  const r = (ratePct || 0) / 100 / 12;
  const n = (years || 0) * 12;
  if (n <= 0) return null;
  let FV = P * Math.pow(1 + r, n);
  if (pm > 0 && r > 0) FV += pm * ((Math.pow(1 + r, n) - 1) / r);
  else if (pm > 0) FV += pm * n;
  const totalContrib = P + pm * n;
  const totalEarned = FV - totalContrib;
  const roi = totalContrib > 0 ? ((totalEarned / totalContrib) * 100) : 0;
  return { finalValue: FV, totalContrib, totalEarned, roi };
}

// helper exporters for browser usage
function formatAmount(val) {
  // wrapper around utils.formatCurrency if available
  if (typeof formatCurrency === 'function') {
    return formatCurrency(val);
  }
  return '$' + val.toLocaleString('en-US', {minimumFractionDigits:2,maximumFractionDigits:2});
}

// expose functions in browser global and Node module
const Finance = {
  calcMortgageValues,
  calcEMIValues,
  calcCompoundValues,
  formatAmount
};

if (typeof window !== 'undefined') {
  window.Finance = Finance;
}

if (typeof module !== 'undefined' && module.exports) {
  module.exports = Finance;
}
