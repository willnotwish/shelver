import { Controller } from "@hotwired/stimulus"
import Konva from 'konva'
import Ruler from './rulers'

// Connects to data-controller="unit-preview-canvas"

export default class extends Controller {
  static targets = ['canvas']
  static values = { 
    groups: Array,
    scale: Number,
    boundingBox: Object,
    margins: Object,
    constraints: Array
  }

  initialize() {
  }

  connect() {
    const bounds = this.boundingBoxValue

    const xOrigin = this.marginsValue.left || 200
    const yOrigin = this.marginsValue.top || 200

    const xRulerExtension = this.marginsValue.right || 80
    const yRulerExtension = this.marginsValue.bottom || 80

    this.stage = new Konva.Stage({
      container: 'unit_preview_container',
      width: this.canvasTarget.clientWidth,
      height: this.canvasTarget.clientHeight,
      scaleX: this.scaleValue,
      scaleY: this.scaleValue,
    })

    const layer = new Konva.Layer()
    this.stage.add(layer)

    const xRuler = new Ruler({
      orientation: 'horizontal',
      x: xOrigin,
      y: yOrigin / 2,
      name: 'X Ruler (width)',
      length: bounds.width + xRulerExtension,
      majorInterval: 500,
      minorInterval: 100,
      majorTickLength: 20,
      minorTickHeight: 10,
      leadIn: 20
    })

    const yRuler = new Ruler({
      orientation: 'vertical',
      x: xOrigin / 2,
      y: yOrigin,
      name: 'Y Ruler (height)',
      length: bounds.height + yRulerExtension,
      majorInterval: 200,
      minorInterval: 100,
      majorTickLength: 30,
      minorTickHeight: 10,
      leadIn: 10,
      // outline: true,
    })

    const boundingRect = new Konva.Rect({
      stroke: 'slate',
      strokeWidth: 1,
      dash: [20, 20],
      offsetX: -xOrigin,
      offsetY: -yOrigin,
      ...bounds
    })

    const mainGroup = new Konva.Group({
      name: 'main group',
      offsetX: -xOrigin,
      offsetY: -yOrigin
    })

    const mdf = {
      fill: 'BurlyWood',
      stroke: 'black'
    }
    this.groupsValue.forEach(g => {
      const unitGroup = new Konva.Group(g)
      _groupRects(g.rects, unitGroup, mdf)
      // if (g.name) {
      //   const simpleLabel = new Konva.Text({
      //     x: g.x + 50,
      //     y: g.y,
      //     text: g.name,
      //     fontSize: 32
      //   })
      //   layer.add(simpleLabel)
      // }
      mainGroup.add(unitGroup)
    })

    const constraints = new Konva.Group({
      name: 'constraints',
      offsetX: -xOrigin,
      offsetY: -yOrigin
    })

    this.constraintsValue.forEach(specification => {
      constraints.add(new Konva.Rect({fill: 'lightgrey', ...specification}))
    })

    const topLevelGroups = [xRuler, yRuler, boundingRect, mainGroup, constraints]
    topLevelGroups.forEach(group => layer.add(group))
  }

  disconnect() {
    this.stage.destroy()
  }
}

function _groupRects(rectangles, group, defaults) {
  if (!rectangles) {
    return
  }

  rectangles.forEach(rect => group.add(new Konva.Rect({...defaults, ...rect})))
}
