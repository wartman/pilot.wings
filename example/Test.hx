import pilot.wings.PortalTarget.PortalTargetId;
import pilot.wings.*;

class Test {

  public static function main() {
    var id = new PortalTargetId("modal");
    Pilot.mount(
      Pilot.dom.getElementById('root'),
      Pilot.html(<>
        <PortalTarget id={id} />
        <ModalTest id={id} />
      </>)
    );
  }

}

class ModalTest extends pilot.Component {

  @:attribute(mutable = true) var showModal:Bool = false;
  @:attribute var id:PortalTargetId;

  override function render() return html(<>
    <button onClick={_ -> showModal = true}>Show Modal</button>
    <if {showModal}>
      <Modal 
        target={id} 
        requestClose={() -> showModal = false}
        overlayStyle@style={
          background: rgba(0, 0, 0, 0.5);
        }
        modalStyle@style={
          background: #fff;
          padding: 1rem;
          width: 100%;
          max-width: 900px;          
        }
        position={PositionCentered}
      >
        Hello world.
      </Modal>
    </if>
  </>);

}

// import pilot.Style;
// import pilot.VNode;
// import pilot.StatefulWidget;
// import js.Browser;
// import pilot.wings.*;

// using pilot.Differ;

// class Test {
  
//   public static function main() {
//     var root = Browser.document.getElementById('root');
//     root.patch(new Box({
//       children: [
//         new PortalTarget({ id: PortalTarget.defaultTarget }),
//         new Box({
//           style: Style.global({
//             'h1, h2, h3': {
//               margin: 0
//             },
//           }),
//           children: [
//             new Header({
//               children: [
//                 new HeadingText({
//                   type: HeadingMain,
//                   content: 'Test'
//                 }),
//                 new ModalTest({ isOpen: false })
//               ]
//             }),
//           ]
//         })
//       ]
//     }));
//   }

// }

// class ModalTest extends StatefulWidget {

//   @:state var isOpen:Bool;

//   override function build():VNode {
//     return new Box({
//       children: [
//         new Button({
//           onClick: _ -> isOpen = !isOpen,
//           children: [ 'Show Modal' ]
//         }),
//         if (isOpen) new Modal({
//           overlayStyle: Style.create({
//             background: 'rgba(0, 0, 0, 0.5)',
//           }),
//           modalStyle: Style.create({
//             background: '#FFF',
//             padding: '1rem',
//             width: '100%',
//             maxWidth: '900px',
//           }),
//           target: PortalTarget.defaultTarget,
//           position: PositionCentered,
//           requestClose: () -> isOpen = false,
//           header: new ModalHeader({
//             title: 'Test',
//             style: Style.create({
//               marginBottom: '10px',
//               lineHeight: '30px',
//               height: '30px',
//               fontSize: '12px',
//             }),
//             requestClose: () -> isOpen = false,
//           }),
//           child: new Box({
//             children: [ 
//               'This is a modal!'
//             ]
//           })
//         }) else null
//       ]
//     });
//   }

// }
