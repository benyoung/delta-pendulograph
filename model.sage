#!/usr/bin/python

var("x,y,z")

class arm():
    def __init__(self, radius, standoff, z_rot, location):
        self.radius = radius
        self.standoff = standoff
        self.z_rot = z_rot
        self.location = vector(location)

    def _x_rot(self, point, ang):
        return matrix(3,3,[
                [ 1,        0,        0,],
                [ 0, cos(ang),-sin(ang),],
                [ 0, sin(ang), cos(ang),],
                ]) *point

    def _y_rot(self, point, ang):
        return matrix(3,3,[
                [ cos(ang), 0, sin(ang),],
                [        0, 1,        0,],
                [-sin(ang), 0, cos(ang),],
                ]) *point

    def _z_rot(self, point, ang):
        return matrix(3,3,[
                [cos(ang), -sin(ang), 0,],
                [sin(ang),  cos(ang), 0,],
                [       0,         0, 1,],
                ]) *point

    def move_to_position(self, point):
        p = point + self.location
        p = self._z_rot(p, self.z_rot)
        return p

    def upper_pos(self, x_ang, y_ang, use_standoff=1):
        p = vector((-self.standoff * use_standoff, 0, self.radius))
        p = self._x_rot(p, x_ang)
        p = self._y_rot(p, y_ang)
        return self.move_to_position(p)

    def lower_pos(self, x_ang, y_ang, use_standoff=1):
        p = vector((-self.standoff * use_standoff, 0, -self.radius))
        p = self._x_rot(p, x_ang)
        p = self._y_rot(p, y_ang)
        return self.move_to_position(p)

    def show(self, x_ang, y_ang):
        pendulum_upper = self.upper_pos(x_ang, y_ang, 0)
        standoff_upper = self.upper_pos(x_ang, y_ang, 1)
        pendulum_lower = self.lower_pos(x_ang, y_ang, 0)
        standoff_lower = self.lower_pos(x_ang, y_ang, 1)
        return line([standoff_upper, pendulum_upper, pendulum_lower, standoff_lower])


class pendulograph():
    def __init__(self, radius, standoff, dist_from_center, arm_len):
        self.arms = []
        self.arm_len = arm_len
        for ang in [0, 2*pi/3, 4*pi/3]:
            self.arms.append(arm(radius, standoff, ang, (dist_from_center,0,0)))
        self.upper_guess = self.compute_upper_guess()
        self.lower_guess = self.compute_lower_guess()
        

    def _sphere(self, center, rad):
        (a,b,c) = center
        return (x-a)**2 + (y-b)**2 + (z-c)**2 == rad**2

    def _newton_solver(functions, guess, eps=0.001):
        functions = vector(functions)
        Jacobian = Matrix(3,3,[[f.derivative(x), f.derivative(y), f.derivative(z)] for f in functions])
        while functions.subs({x:guess[0], y:guess[1], z:guess[2]}).norm() > eps:
            J = Jacobian.subs({x:guess[0], y:guess[1], z:guess[2]})
            b = -vector([f.subs({x:guess[0], y:guess[1], z:guess[2]}).n(40) for f in functions])
            guess = guess + J.solve_right(b)
        return guess

    # use this for the newtons method solver, for some reason it seems to work
    def compute_upper_guess(self):
        equations = []
        spheres = []
        for a in self.arms:
            center = a.upper_pos(0, 0)
            equations.append(self._sphere(center, self.arm_len))
        solutions =  solve(equations, (x,y,z))
        solutions = [vector((x,y,z)).subs(s).n(20) for s in solutions]
        if solutions[0][2] < solutions[1][2]:
            return solutions[0]
        else:
            return solutions[1]

    # use this for the newtons method solver, for some reason it seems to work
    def compute_lower_guess(self):
        equations = []
        spheres = []
        for a in self.arms:
            center = a.lower_pos(0, 0)
            equations.append(self._sphere(center, self.arm_len))
        solutions =  solve(equations, (x,y,z))
        solutions = [vector((x,y,z)).subs(s).n(20) for s in solutions]
        if solutions[0][2] > solutions[1][2]:
            return solutions[0]
        else:
            return solutions[1]

    def show(self, angle_list):
        arm_image = sum(a.show(x_ang, y_ang) for (a, (x_ang, y_ang)) in zip(self.arms, angle_list))

        
P = pendulograph(2.5, 0.3, 3, 3.5)

