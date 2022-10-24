package Boxsack

  model Fixation
  Boxsack.TranslatoryPort translatoryPort annotation(
      Placement(visible = true, transformation(origin = {0, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -16}, extent = {{-46, -46}, {46, 46}}, rotation = 0)));
  
  equation
  
  translatoryPort.s=0;

  annotation(
      Icon(graphics = {Rectangle(origin = {0, 36}, fillPattern = FillPattern.Solid, extent = {{-100, 20}, {100, -20}})}));end Fixation;

  connector TranslatoryPort
    flow Modelica.Units.SI.Force F;
    //Kraft
    Modelica.Units.SI.Distance s;
    //Weg
    annotation(
      Icon(graphics = {Ellipse(fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid,extent = {{-94, 96}, {94, -96}}, endAngle = 360)}));
  end TranslatoryPort;

  model Spring
  Boxsack.TranslatoryPort translatoryPort annotation(
      Placement(visible = true, transformation(origin = {-2, 94}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Boxsack.TranslatoryPort translatoryPort1 annotation(
      Placement(visible = true, transformation(origin = {-12, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1, -77}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  
  parameter Real c = 4 "Federkonstante";
  parameter Real b=0.02 "Dämpfung";
  
  Real s_rel; //Relativer Federweg
  
  equation
  
  translatoryPort1.F+translatoryPort.F=0; //Summe der Flüsse in den Connectoren ist NULL.
  translatoryPort1.F=c*s_rel + b*der(s_rel); //Federgleichung
  s_rel=translatoryPort1.s-translatoryPort.s; //Relativer Federweg
  
  annotation(
      Icon(graphics = {Line(origin = {1.93, -1}, points = {{-1.92697, 75}, {-1.92697, 35}, {40.073, 35}, {-41.927, 1}, {42.073, 1}, {-39.927, -19}, {40.073, -19}, {-41.927, -39}, {-1.92697, -39}, {-1.92697, -75}}, thickness = 1.75)}));end Spring;

  model Mass
  Boxsack.TranslatoryPort translatoryPort annotation(
      Placement(visible = true, transformation(origin = {-2, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {3, 61}, extent = {{-43, -43}, {43, 43}}, rotation = 0)));
  
  parameter Modelica.Units.SI.Mass m=1 "Masse";
  constant Modelica.Units.SI.Acceleration g =Modelica.Constants.g_n; //Erdbeschleunigung
  Modelica.Units.SI.Acceleration a;
  Modelica.Units.SI.Velocity v;
  
  equation

  der(translatoryPort.s)=v;
  der(v)=a;
  translatoryPort.F=m*a+ m*g;
  
  annotation(
      Icon(graphics = {Polygon(origin = {3, -22}, fillPattern = FillPattern.Solid, points = {{-57, 54}, {-99, 12}, {-61, -68}, {33, -74}, {91, -60}, {99, 26}, {41, 74}, {-57, 54}})}));end Mass;

  model Testmodell
  Boxsack.Fixation fixation annotation(
      Placement(visible = true, transformation(origin = {1, 81}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  Boxsack.Spring spring(b = 0.5)  annotation(
      Placement(visible = true, transformation(origin = {1, -1}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Boxsack.Mass mass annotation(
      Placement(visible = true, transformation(origin = {0, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(fixation.translatoryPort, spring.translatoryPort) annotation(
      Line(points = {{2, 78}, {2, 28}}));
  connect(spring.translatoryPort1, mass.translatoryPort) annotation(
      Line(points = {{2, -28}, {0, -28}, {0, -64}}));
  end Testmodell;

end Boxsack;
