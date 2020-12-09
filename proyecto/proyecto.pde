import nub.core.*;
import nub.primitives.*;
import nub.processing.*;
import nub.ik.solver.*;
import nub.ik.animation.*;
import nub.core.constraint.*;

Scene scene;
void setup(){
  size(800,600,P3D);

  scene = new Scene(this);
  scene.setBounds(200);
  scene.fit(1);

  Skeleton skeleton = new Skeleton();
  //definicion de nodos
  Node joint0 = skeleton.addJoint("Joint 0"); 
  joint0.translate(new Vector(0,-scene.radius()/2));//cabeza
  Node joint1 = skeleton.addJoint("Joint 1", "Joint 0");
  joint1.translate(new Vector(0,20, 0));//cuello-cintura
  Node joint11 = skeleton.addJoint("Joint 11", "Joint 0");
  joint11.translate(new Vector(0,20, 0));//cuello-brazo der
  Node joint12 = skeleton.addJoint("Joint 12", "Joint 0");
  joint12.translate(new Vector(0,20, 0));//cuello-brazo izq
  Node joint2 = skeleton.addJoint("Joint 2","Joint 11"); 
  joint2.translate(new Vector(30,25, 0)); //brazo derecha
  Node joint3 = skeleton.addJoint("Joint 3", "Joint 2");
  joint3.translate(new Vector(0,35, 0));//mano derecha
  Node joint4 = skeleton.addJoint("Joint 4", "Joint 12");
  joint4.translate(new Vector(-30,25, 0));//brazo izq
  Node joint5 = skeleton.addJoint("Joint 5", "Joint 4");
  joint5.translate(new Vector(0,35, 0));//mano izq
  Node joint6 = skeleton.addJoint("Joint 6", "Joint 1");
  joint6.translate(new Vector(0,65, 0)); //cintura-pierna der
  Node joint13 = skeleton.addJoint("Joint 13", "Joint 1");
  joint13.translate(new Vector(0,65, 0)); //cintura-pierna izq
  Node joint7 = skeleton.addJoint("Joint 7", "Joint 6");
  joint7.translate(new Vector(15,35, 0)); //pierna derecha
  Node joint8 = skeleton.addJoint("Joint 8", "Joint 7");
  joint8.translate(new Vector(0,35, 0)); //pie derecho
  Node joint9 = skeleton.addJoint("Joint 9", "Joint 13");
  joint9.translate(new Vector(-15,35, 0)); //pierna izq
  Node joint10 = skeleton.addJoint("Joint 10", "Joint 9");
  joint10.translate(new Vector(0,35, 0)); //pie izq


  BallAndSocket constraint0 = new BallAndSocket(radians(0), radians(0));

  joint0.setConstraint(constraint0);
  joint1.setConstraint(constraint0);

  BallAndSocket constraint1 = new BallAndSocket(radians(40), radians(10));
  constraint1.setRestRotation(joint11.rotation(), new Vector(1,0,0), new Vector(1,0,0));
  joint11.setConstraint(constraint1);
  
  BallAndSocket constraint4 = new BallAndSocket(radians(40), radians(10));
  constraint4.setRestRotation(joint12.rotation(), new Vector(1,0,0), new Vector(-1,0,0));
  joint12.setConstraint(constraint4);


  Hinge constraint2 = new Hinge(radians(0), radians(120));
  constraint2.setRestRotation(joint2.rotation(), new Vector(0,1,0), new Vector(1,0,0));
  joint2.setConstraint(constraint2);
  joint4.setConstraint(constraint2);
  
  Hinge constraint3 = new Hinge(radians(0), radians(160));
  constraint3.setRestRotation(joint7.rotation(), new Vector(0,1,0), new Vector(-1,0,0));
  joint7.setConstraint(constraint3);
  joint9.setConstraint(constraint3);
  
  Hinge constraint5 = new Hinge(radians(0), radians(160));
  constraint5.setRestRotation(joint7.rotation(), new Vector(0,1,0), new Vector(1,0,0));
  joint6.setConstraint(constraint5);
  joint13.setConstraint(constraint5);
 

  skeleton.enableIK();
  //Agregar targets
  skeleton.addTarget("Joint 5");
  skeleton.addTarget("Joint 3");
  skeleton.addTarget("Joint 8");
  skeleton.addTarget("Joint 10");
 
  skeleton.restoreTargetsState();
  scene.enableHint(Scene.BACKGROUND | Scene.AXES);
}
void draw(){
  lights();
  scene.render();
}

void mouseMoved() {
    scene.mouseTag();
}

void mouseDragged() {
    if (mouseButton == LEFT){
        scene.mouseSpin();
    } else if (mouseButton == RIGHT) {
        scene.mouseTranslate();
    } else {
        scene.scale(mouseX - pmouseX);
    }
}

void mouseWheel(MouseEvent event) {
    scene.scale(event.getCount() * 20);
}

void mouseClicked(MouseEvent event) {
    if (event.getCount() == 2)
        if (event.getButton() == LEFT)
            scene.focus();
        else
            scene.align();
}
