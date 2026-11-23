/* ============ TODAY front garden (SD-06 mapped onto the plan, checked against the photos and video) ============ */
const T_ = G.today;
// Wide exposed-aggregate driveway running the length of the house front (SD-06 "DRIVE", about 4 m wide), bluestone edged.
const driveStrip = [[17.6, 47.2], [27.9, 47.2], [27.9, 48.4], [32.95, 48.4], [32.95, 51.4], [17.6, 51.4]];
ground(driveStrip, GL, MAT.agg, T_, { layer: 3 });
ground(rect(17.6, 45.44, 20.21, 47.2), GL, MAT.agg, T_, { layer: 3 });
edgeStrip([[17.6, 51.52], [32.95, 51.52]], T_); edgeStrip([[20.3, 47.08], [27.9, 47.08], [27.9, 48.28], [32.95, 48.28]], T_);
// main driveway: SD-06 shows it widening from the drive gate to the garage forecourt
const leftEdge = y => 33.45 + (y - 51) / 7.5 * 1.45;
const todayDrive = [[33.0, 51.0], [39.0, 51.0], [39.0, 58.5], [34.9, 58.5], [33.45, 51.0]];
ground(todayDrive, GL, MAT.agg, T_, { layer: 2 });
edgeStrip([[33.45, 51.1], [34.9, 58.5]], T_);
slab(rect(17.6, 45.44, 20.0, 46.3), GL, GL + 0.2, MAT.blue, T_);
// lawn with its red-brick mowing edge
const todayLawn = [[12.1, 49.2], [13.3, 48.2], [17.45, 48.2], [17.5, 51.65], [31.0, 51.65], [31.4, 53.5], [31.0, 57.5], [28.3, 60.6], [24.0, 61.8], [19.6, 62.2], [17.6, 62.9], [14.4, 62.8], [12.7, 60.8], [11.95, 56.5], [11.7, 52.0]];
const circPave = [16.0, 60.5], circR = 2.3;
ground(todayLawn, GL, MAT.lawn, T_, { layer: 1 });
ground(ribbon(todayLawn.concat([todayLawn[0]]), 0.3), GL, MAT.brick, T_, { layer: 2 });
// existing brick paths (from the photos and the walk-around video)
const fy = x => frontY(x) - 1.55;
const brickPaths = [
  [[17.6, 49.6], [16.0, 49.95], [14.2, 49.5], [12.6, 48.5], [11.5, 47.3], [11.25, 46.2], [11.2, 44.0], [11.15, 38.3], [northX(37.8) + 0.3, 37.8]],
  [[11.5, 48.6], [10.7, 51.5], [10.5, 56.0], [10.9, 60.0], [12.2, 62.6], [14.3, fy(14.3)]],
  [[14.3, fy(14.3)], [18.0, fy(18.0)], [22.0, fy(22.0)], [26.0, fy(26.0)], [29.6, fy(29.6)]],
  [[16.45, frontY(16.45) - 0.2], [16.4, fy(16.4)]],
  [[29.6, fy(29.6)], [31.6, 61.0], [32.6, 58.0], [32.7, 54.5], [32.2, 52.0]],
];
brickPaths.forEach(p => ground(ribbon(p, 0.85), GL, MAT.brick, T_, { layer: 3 }));
// circular flagstone paving with birdbath, stone bench and pedestal on its far side
ground(circle(circPave[0], circPave[1], circR), GL, MAT.flag, T_, { layer: 4 });
birdbath(14.6, 61.55, T_);
(function bench() { const cx = 16.15, cy = 62.3; box(cx, cy, GL + 0.38, 1.5, 0.48, 0.09, MAT.stone, T_); [cx - 0.55, cx + 0.55].forEach(x => box(x, cy, GL, 0.25, 0.42, 0.38, MAT.stone, T_)); box(17.5, 62.0, GL, 0.38, 0.38, 0.9, MAT.stone, T_); box(17.5, 62.0, GL + 0.9, 0.48, 0.48, 0.1, MAT.stone, T_); })();
// brick step at the pedestrian gate (garden sits above the footpath)
skirt([15.6, frontY(15.6) - 0.05], [17.35, frontY(17.35) - 0.05], 0, 0, T_);
slab([[15.7, frontY(15.7) - 0.4], [17.3, frontY(17.3) - 0.4], [17.3, frontY(17.3)], [15.7, frontY(15.7)]], 0, 0.22, MAT.brick, T_);
// the two large trees to be removed (SD-06 positions), plus the tall trunks behind the bench
tree({ x: 25.58, y: 55.4, h: 16, r: 6.7, color: 0x5f8248, kind: 'flame', group: T_, mound: true });
tree({ x: 18.69, y: 59.05, h: 20, r: 5.5, color: 0x7d8f69, kind: 'gum', group: T_ });
tree({ x: 12.3, y: 64.0, h: 14, r: 3.0, color: 0x7f9070, kind: 'gum', group: T_ });
// ornamental pears lining both sides of the driveway
const pears = [[leftEdge(52.5) - 0.55, 52.5], [leftEdge(56.0) - 0.55, 56.0], [34.65, 59.6], [39.6, 46.5], [39.6, 50.0], [39.6, 53.5], [39.6, 57.0], [39.7, 60.5]];
pears.forEach(([x, y]) => tree({ x, y, h: 9.5, r: 2.3, color: 0x5f8b46, kind: 'pear', group: T_ }));
const kitT = newKit();
[[20.5, 46.3, 22.9, 46.3], [23.2, 46.78, 26.6, 46.78], [26.9, 46.25, 27.7, 46.25], [28.3, 47.95, 32.3, 47.95]].forEach(([x0, y0, x1, y1]) => { for (let t = 0; t <= 1.001; t += 0.12) plantKit('agapanthus', lerp(x0, x1, t) + R(-0.08, 0.08), lerp(y0, y1, t) + R(-0.08, 0.08), GL, kitT); });
function distSeg(px, py, a, b) { const dx = b[0] - a[0], dy = b[1] - a[1]; const L2 = dx * dx + dy * dy || 1; const t = clamp(((px - a[0]) * dx + (py - a[1]) * dy) / L2, 0, 1); return Math.hypot(px - a[0] - t * dx, py - a[1] - t * dy); }
const nearPaths = (x, y, d) => brickPaths.some(p => p.some((q, i) => i < p.length - 1 && distSeg(x, y, q, p[i + 1]) < d));
function freeToday(x, y) {
  if (y < 47.0 || y > frontY(x) - 1.1 || x < northX(y) + 0.45 || x > 39.3) return false;
  if (inPoly(x, y, todayLawn) || inPoly(x, y, rampPoly) || inPoly(x, y, todayDrive) || inPoly(x, y, driveStrip) || inRect(x, y, [32.9, 44.5, 39.1, 51.1])) return false;
  if (nearPaths(x, y, 0.72) || dist(x, y, circPave) < circR + 0.25) return false;
  for (const t of [[18.69, 59.05], [12.3, 64.0], [17.5, 62.0], [14.6, 61.55]].concat(pears)) if (dist(x, y, t) < 0.8) return false;
  if (x < 17.6 && y < 49.8 && x > 12.0) return false;
  return true;
}
for (let y = 47.2; y < 66; y += 0.8) for (let x = 8.5; x < 39.3; x += 0.8) { const px = x + R(-0.3, 0.3), py = y + R(-0.3, 0.3); if (!freeToday(px, py)) continue; const r = rnd();
  const nearDrive = px > 32.6 || (px > 30 && py < 53);
  if (nearDrive) { plantKit(r < 0.75 ? 'grass' : 'agapanthus', px, py, GL, kitT, 1.2); continue; }
  plantKit(r < 0.3 ? 'shrub' : r < 0.42 ? 'bigshrub' : r < 0.55 ? 'agapanthus' : r < 0.66 ? 'hydrangea' : r < 0.76 ? 'cordyline' : r < 0.88 ? 'arthropodium' : 'grass', px, py, GL, kitT, 1.1); }
for (let y = 38.6; y < 47; y += 0.85) for (let x = northX(y) + 0.5; x < 10.6; x += 0.85) if (!nearPaths(x, y, 0.6)) plantKit(rnd() < 0.5 ? 'shrub' : 'arthropodium', x, y, GL, kitT, 1.1);
for (let y = 51.4; y < 58.4; y += 0.5) plantKit('grass', leftEdge(y) - 0.3 + R(-0.08, 0.08), y, GL, kitT, 1.2);
for (let y = 45.3; y < 58.4; y += 0.5) plantKit('grass', 39.4 + R(-0.08, 0.08), y, GL, kitT, 1.2);
flushKit(kitT, T_, false);
todayLawn.forEach(([x, y], i) => { if (i % 2 && !nearPaths(x, y, 0.6)) gardenLight(x, y, 'today'); });

