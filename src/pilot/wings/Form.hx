package pilot.wings;

import pilot.VNode;

// todo
abstract Form(VNode) to VNode {

  public inline function new(props:{

  }) {
    this = new VNode({
      name: 'form',
      props: {},
      children: []
    });
  }

}