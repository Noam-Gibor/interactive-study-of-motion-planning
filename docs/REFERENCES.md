# References

Grouped by how the talk uses them. Each entry lists the scenes that rely on it. The search links open Google Scholar on the exact title. BibTeX for all entries: [`references.bib`](references.bib).

## Prof. Zvi Shiller

**[SL92]** Z. Shiller and H.-H. Lu, "Computation of path constrained time optimal motions with dynamic singularities," *ASME Journal of Dynamic Systems, Measurement, and Control*, vol. 114, no. 1, pp. 34-40, 1992.
[Scholar](https://scholar.google.com/scholar?q=%22Computation+of+path+constrained+time+optimal+motions+with+dynamic+singularities%22)
*Used in scenes 10-15 and 18.* Reducing the robot to the two-state system (s, ṡ) on a fixed path; the admissible acceleration window (Fig. 1); the velocity limit curve (Eq. 8); sinks, sources, and tangency, discontinuity and critical switching points (Figs. 2-3); singular arcs, and why the optimal motion slides along the limit curve instead of chattering (Figs. 14-16, Eq. 19).

**[SD89]** Z. Shiller and S. Dubowsky, "Robot path planning with obstacles, actuator, gripper, and payload constraints," *The International Journal of Robotics Research*, vol. 8, no. 6, pp. 3-18, 1989.
[Scholar](https://scholar.google.com/scholar?q=%22Robot+path+planning+with+obstacles%2C+actuator%2C+gripper%2C+and+payload+constraints%22)
*Used in scene 20.* Uses the time-optimal motion along a path as the cost, and optimises the path itself around obstacles: the "both at once" side of the honest limit.

**[SD91]** Z. Shiller and S. Dubowsky, "On computing the global time-optimal motions of robotic manipulators in the presence of obstacles," *IEEE Transactions on Robotics and Automation*, vol. 7, no. 6, pp. 785-797, 1991.
[Scholar](https://scholar.google.com/scholar?q=%22On+computing+the+global+time-optimal+motions+of+robotic+manipulators+in+the+presence+of+obstacles%22)
*Background for scene 20.* Global search over paths with the time-optimal speed as the cost.

**[SG91]** Z. Shiller and Y.-R. Gwo, "Dynamic motion planning of autonomous vehicles," *IEEE Transactions on Robotics and Automation*, vol. 7, no. 2, pp. 241-249, 1991.
[Scholar](https://scholar.google.com/scholar?q=%22Dynamic+motion+planning+of+autonomous+vehicles%22+Shiller)
*Background for scenes 11-13.* Velocity limits of a wheeled vehicle from sliding and tip-over along a path: the vehicle version of the grip limit used for the mouse.

## Time-optimal motion along a path

**[BDG85]** J. E. Bobrow, S. Dubowsky and J. S. Gibson, "Time-optimal control of robotic manipulators along specified paths," *The International Journal of Robotics Research*, vol. 4, no. 3, pp. 3-17, 1985.
[Scholar](https://scholar.google.com/scholar?q=%22Time-optimal+control+of+robotic+manipulators+along+specified+paths%22)
*Scene 13.* Bang-bang speed profile by forward and backward integration in the phase plane.

**[SM85]** K. G. Shin and N. D. McKay, "Minimum-time control of robotic manipulators with geometric path constraints," *IEEE Transactions on Automatic Control*, vol. 30, no. 6, pp. 531-541, 1985.
[Scholar](https://scholar.google.com/scholar?q=%22Minimum-time+control+of+robotic+manipulators+with+geometric+path+constraints%22)
*Scene 13.*

**[KZ86]** K. Kant and S. W. Zucker, "Toward efficient trajectory planning: the path-velocity decomposition," *The International Journal of Robotics Research*, vol. 5, no. 3, pp. 72-89, 1986.
[Scholar](https://scholar.google.com/scholar?q=%22Toward+efficient+trajectory+planning%3A+the+path-velocity+decomposition%22)
*Scenes 7 and 10.* Plan the path first, then the speed along it.

**[Pham14]** Q.-C. Pham, "A general, fast, and robust implementation of the time-optimal path parameterization algorithm," *IEEE Transactions on Robotics*, vol. 30, no. 6, pp. 1533-1540, 2014.
[Scholar](https://scholar.google.com/scholar?q=%22A+general%2C+fast%2C+and+robust+implementation+of+the+time-optimal+path+parameterization+algorithm%22)
*Scenes 12-13 notes.* The "maximum velocity curve" (MVC) naming and the alpha/beta profiles.

**[PCLN17]** Q.-C. Pham, S. Caron, P. Lertkultanon and Y. Nakamura, "Admissible velocity propagation: beyond quasi-static path planning for high-dimensional robots," *The International Journal of Robotics Research*, vol. 36, no. 1, pp. 44-67, 2017 (online 2016).
[Scholar](https://scholar.google.com/scholar?q=%22Admissible+velocity+propagation%3A+beyond+quasi-static+path+planning+for+high-dimensional+robots%22)
*Scene 20.* Carries the interval of reachable speeds along each path piece inside a sampling-based planner.

## Smooth trajectories with B-splines

**[VDSDD09]** D. Verscheure, B. Demeulenaere, J. Swevers, J. De Schutter and M. Diehl, "Time-optimal path tracking for robots: a convex optimization approach," *IEEE Transactions on Automatic Control*, vol. 54, no. 10, pp. 2318-2327, 2009.
[Scholar](https://scholar.google.com/scholar?q=%22Time-optimal+path+tracking+for+robots%3A+a+convex+optimization+approach%22)
*Scene 16.* Writing the problem in b = ṡ² makes the constraints linear and the time convex; the exact optimum the deck's re-solve loop approximates.

**[GZ07]** A. Gasparetto and V. Zanotto, "A new method for smooth trajectory planning of robot manipulators," *Mechanism and Machine Theory*, vol. 42, no. 4, pp. 455-471, 2007.
[Scholar](https://scholar.google.com/scholar?q=%22A+new+method+for+smooth+trajectory+planning+of+robot+manipulators%22)
*Scenes 16-17.* B-spline trajectories that trade execution time against jerk.

## Inspiration

**[Ver]** Veritasium, "The Fastest Maze-Solving Competition On Earth," YouTube. https://www.youtube.com/watch?v=ZMQbHMgK2rw (turn library and command chain, around 16:00 to 16:30).

## Course material

Motion Planning lectures L1-L9, Prof. Zvi Shiller, Ariel University (not public). The speaker notes point to specific slides, for example the friction-circle derivation (L6 slide 7, L9 slide 28) and the bang-bang argument (L4 slides 12-14, L6 slides 8-11).
