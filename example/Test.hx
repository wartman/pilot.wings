import pilot.Style;
import pilot.VNode;
import pilot.StatefulWidget;
import js.Browser;
import pilot.wings.*;

using pilot.Differ;

class Test {
  
  public static function main() {
    Style.global({
      'h1, h2, h3': {
        margin: 0
      },
    });

    var root = Browser.document.getElementById('root');
    root.patch(new Box({
      children: [
        new PortalTarget({ id: PortalTarget.defaultTarget }),
        new ModalTest({ isOpen: false }),
      ]
    }));
  }

}

class ModalTest extends StatefulWidget {

  @:state var isOpen:Bool;

  override function build():VNode {
    return new Box({
      children: [
        new Button({
          onClick: _ -> isOpen = !isOpen,
          children: [ 'Show Modal' ]
        }),
        if (isOpen) new Modal({
          overlayStyle: Style.create({
            background: 'rgba(0, 0, 0, 0.5)',
          }),
          modalStyle: Style.create({
            background: '#FFF'
          }),
          target: PortalTarget.defaultTarget,
          requestClose: () -> isOpen = false,
          header: new ModalHeader({
            title: 'Test',
            requestClose: () -> isOpen = false,
          }),
          child: new Box({
            style: Style.create({
              padding: '1rem 0',
            }),
            children: [ 
              'This is a modal!'
            ]
          })
        }) else null
      ]
    });
  }

}
