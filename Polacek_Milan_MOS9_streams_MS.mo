package Steramz
  connector pqscon
    Real p;
    flow Real q;
    stream Real c;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Polygon(origin = {0.874972, -10.1451}, fillColor = {67, 172, 22}, fillPattern = FillPattern.Solid, points = {{-70.7147, 80.3738}, {67.6031, 79.7508}, {68.2261, 4.98442}, {95.0174, -5.60748}, {68.8492, -21.8069}, {67.6031, -79.7508}, {-65.7303, -80.3738}, {-66.3533, -12.4611}, {-95.0138, 4.98442}, {-70.0916, 20.5607}, {-70.0916, 20.5607}})}), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Polygon(origin = {0.874972, -10.1451}, fillColor = {67, 172, 22}, fillPattern = FillPattern.Solid, points = {{-70.7147, 80.3738}, {67.6031, 79.7508}, {68.2261, 4.98442}, {95.0174, -5.60748}, {68.8492, -21.8069}, {67.6031, -79.7508}, {-65.7303, -80.3738}, {-66.3533, -12.4611}, {-95.0138, 4.98442}, {-70.0916, 20.5607}, {-70.0916, 20.5607}})}));
  end pqscon;

  model Psrc
    Steramz.pqscon pqscon1 annotation(Placement(visible = true, transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real P;
    parameter Real c = 0;
  equation
    pqscon1.p = P;
    pqscon1.c = c;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Polygon(origin = {-0.313894, -1.29695}, fillColor = {222, 26, 190}, fillPattern = FillPattern.Solid, points = {{-4.04963, -87.1722}, {6.54227, -61.627}, {82.5547, -61.004}, {86.9161, 86.0365}, {-86.2926, 86.6596}, {-86.9157, -61.004}, {-19.0029, -60.3809}, {-19.0029, -60.3809}})}));
  end Psrc;

  model Resist
    Steramz.pqscon pqscon2 annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real R = 1;
    parameter Real L = 1;
    Steramz.pqscon pqscon1 annotation(Placement(visible = true, transformation(origin = {-80, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-98, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    if L > 0 then
      pqscon1.p - pqscon2.p = R * pqscon1.q + L * der(pqscon1.q);
    else
      pqscon1.p - pqscon2.p = R * pqscon1.q;
    end if;
    pqscon1.q + pqscon2.q = 0;
    inStream(pqscon1.c) = pqscon2.c;
    inStream(pqscon2.c) = pqscon1.c;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {1.87, 11.21}, fillColor = {141, 57, 49}, fillPattern = FillPattern.Solid, extent = {{-89.1, 40.5}, {89.1, -40.5}}), Text(origin = {-8, -72}, extent = {{-90, 18}, {90, -18}}, textString = "R=%R  L=%L")}));
  end Resist;

  model Sens
    Real c;
    Steramz.pqscon pqscon1 annotation(Placement(visible = true, transformation(origin = {0, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    pqscon1.q = 0;
    pqscon1.c = 0;
    c = inStream(pqscon1.c);
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-2.18, 46.42}, fillPattern = FillPattern.Solid, extent = {{-75.08, 35.2}, {75.08, -35.2}}), Polygon(origin = {-18.65, 5.82}, fillPattern = FillPattern.Solid, points = {{18.6809, -76.527}, {69.117, 27.822}, {-33.0637, 27.822}, {18.6809, -76.527}})}));
  end Sens;

  model Model1
    Steramz.Resist resist1(R = 1, L = 0) annotation(Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Steramz.Resist resist2(R = 1, L = 1) annotation(Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Steramz.Psrc psrc2(P = 2, c = 2) annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Steramz.Psrc psrc1(P = 1, c = 1) annotation(Placement(visible = true, transformation(origin = {-80, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Steramz.Sens sens1 annotation(Placement(visible = true, transformation(origin = {-40, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Steramz.Sens sens2 annotation(Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Steramz.Psrc psrc3(P = 0) annotation(Placement(visible = true, transformation(origin = {40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Steramz.Sens sens3 annotation(Placement(visible = true, transformation(origin = {20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(sens3.pqscon1, psrc3.pqscon1) annotation(Line(points = {{20, 12}, {24.6341, 12}, {24.6341, 10}, {39.5122, 10}, {39.5122, 10}}));
    connect(resist2.pqscon2, psrc3.pqscon1) annotation(Line(points = {{-10, 2}, {40.2439, 2}, {40.2439, 9.7561}, {39.5122, 9.7561}, {39.5122, 9.7561}}));
    connect(resist1.pqscon2, psrc3.pqscon1) annotation(Line(points = {{-30, 22}, {6.34146, 22}, {6.34146, 1.95122}, {39.5122, 1.95122}, {39.5122, 9.5122}, {39.5122, 9.5122}}));
    connect(sens2.pqscon1, resist2.pqscon1) annotation(Line(points = {{-40, -8}, {-28.2486, -8}, {-28.2486, 1.69492}, {-28.2486, 1.69492}}));
    connect(sens1.pqscon1, resist1.pqscon1) annotation(Line(points = {{-40, 32}, {-48.5876, 32}, {-48.5876, 21.1864}, {-48.5876, 21.1864}}));
    connect(psrc1.pqscon1, resist1.pqscon1) annotation(Line(points = {{-80, 30}, {-48.3051, 30}, {-48.3051, 20.339}, {-48.3051, 20.339}}));
    connect(psrc2.pqscon1, resist2.pqscon1) annotation(Line(points = {{-80, -10}, {-28.8136, -10}, {-28.8136, 2.54237}, {-28.8136, 2.54237}}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Model1;

  model tank
    constant Real roLiquid = 1000;
    constant Real gravit = 10;
    parameter Real areaBase = 1;
    parameter Real initVolume = 10;
    parameter Real initConc = 10;
    Real volume;
    Real soluteMass;
    Real height;
    Real conc;
    pqscon pqIn annotation(Placement(visible = true, transformation(origin = {-88, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-88, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pqscon pqOut annotation(Placement(visible = true, transformation(origin = {92, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {88, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  initial equation
    volume = initVolume;
    conc = initConc;
  equation
    roLiquid * gravit * height = pqIn.p;
    pqIn.p = pqOut.p;
    pqIn.c = soluteMass / volume;
    pqIn.c = pqOut.c;
    der(volume) = pqIn.q + pqOut.q;
    volume = height * areaBase;
    conc = actualStream(pqIn.c) + actualStream(pqOut.c);
    der(soluteMass) = pqIn.q * actualStream(pqIn.c) + pqIn.q * actualStream(pqIn.c);
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-6, 10}, fillColor = {0, 85, 255}, fillPattern = FillPattern.Horizontal, extent = {{-62, 52}, {64, -58}}), Text(origin = {1, -68}, extent = {{-65, -24}, {65, 24}}, textString = "%name"), Text(origin = {-77, 86}, extent = {{-23, -14}, {175, 12}}, textString = "S =%areaBase  initVolume = %initVolume
  initConc =%initConc")}));
  end tank;

  model twoTank
    tank tank1 annotation(Placement(visible = true, transformation(origin = {-71, -1}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
    Sens sens1 annotation(Placement(visible = true, transformation(origin = {-20, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    tank tank2(initVolume = 5, initConc = 0) annotation(Placement(visible = true, transformation(origin = {68, -2}, extent = {{-32, -32}, {32, 32}}, rotation = 0)));
    Resist resist1 annotation(Placement(visible = true, transformation(origin = {-2, -1.77636e-15}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
    Sens sens2 annotation(Placement(visible = true, transformation(origin = {16, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(sens2.pqscon1, resist1.pqscon2) annotation(Line(points = {{16, 64}, {16, 4}}));
    connect(tank2.pqIn, resist1.pqscon2) annotation(Line(points = {{40, -22}, {24, -22}, {24, 4}, {16, 4}}));
    connect(sens1.pqscon1, resist1.pqscon1) annotation(Line(points = {{-20, 64}, {-20, 4}}));
    connect(tank1.pqOut, resist1.pqscon1) annotation(Line(points = {{-45, -19}, {-26, -19}, {-26, 4}, {-20, 4}}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end twoTank;
end Steramz;