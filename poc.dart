import 'dart:math'; 

List<double> intersection(x0, y0, r0, x1, y1, r1) {
  var a, dx, dy, d, h, rx, ry;
  var x2, y2;

  dx = x1 - x0;
  dy = y1 - y0;

  d = sqrt((dy*dy) + (dx*dx));

  if (d > (r0 + r1)) {
    /* no solution. circles do not intersect. */
    return [];
  }
  if (d < (r0 - r1).abs()) {
    /* no solution. one circle is contained in the other */
    return [];
  }

  a = ((r0*r0) - (r1*r1) + (d*d)) / (2.0 * d) ;

  x2 = x0 + (dx * a/d);
  y2 = y0 + (dy * a/d);

  h = sqrt((r0*r0) - (a*a));

  rx = -dy * (h/d);
  ry = dx * (h/d);

  var xi = x2 + rx;
  var xi_prime = x2 - rx;
  var yi = y2 + ry;
  var yi_prime = y2 - ry;

  return [xi, xi_prime, yi, yi_prime];
}

int main() {
  print(intersection(1, 1, 2, 1, 3, 1));
  return 0;
}
