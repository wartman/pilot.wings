import pilot.Style;
import pilot.VNode;
import pilot.StatefulWidget;
import js.Browser;
import pilot.wings.*;

using pilot.Differ;

class Test {
  
  public static function main() {
    var root = Browser.document.getElementById('root');
    root.patch(new Box({
      children: [
        new PortalTarget({ id: PortalTarget.defaultTarget }),
        new Box({
          style: Style.global({
            'h1, h2, h3': {
              margin: 0
            },
          }),
          children: [
            new Header({
              children: [
                new HeadingText({
                  type: HeadingMain,
                  content: 'Test'
                }),
                new ModalTest({ isOpen: false })
              ]
            }),
          ]
        })
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
          position: PositionCentered,
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
