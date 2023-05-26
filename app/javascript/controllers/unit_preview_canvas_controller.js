import { Controller } from "@hotwired/stimulus"
import Konva from 'konva'
import { HorizontalRuler } from './rulers'

// Connects to data-controller="unit-preview-canvas"

export default class extends Controller {
  static targets = ['canvas']
  static values = { groups: Array, scale: Number, boundingBox: Object }

  connect() {
    console.log("Bounding box:", this.boundingBoxValue)
    this.stage = new Konva.Stage({
      container: 'unit_preview_container',
      width: this.canvasTarget.clientWidth,
      height: this.canvasTarget.clientHeight,
      scaleX: this.scaleValue,
      scaleY: this.scaleValue,
      // offsetX: -50,
      // offsetY: -50
    })

    const rectDefaults = {
      fill: 'BurlyWood',
      stroke: 'black'
    }

    const boundingBoxDefaults = {
      fill: 'Gainsboro',
      stroke: 'red'
    }

    const _groupRects = (rectangles, group) => {
      if (rectangles) {
        rectangles.forEach(rect => {
          group.add(new Konva.Rect({...rectDefaults, ...rect}))
        })
      }
    }

    const layer = new Konva.Layer()
    this.stage.add(layer)

    // Bounding box
    const bounds = this.boundingBoxValue
    // layer.add(new Konva.Rect({...boundingBoxDefaults, ...bounds.rect}))

    const xRulerHeight = 180
    const yRulerWidth = 100
    const xRulerExtension = 80
    const yRulerExtension = 80

    // Create groups and lay them out
    const xRulerGroup = new Konva.Group({
      name: 'x-ruler group',
      x: yRulerWidth,
      y: xRulerHeight / 2,
  })

    const xRuler = new HorizontalRuler({
      name: 'X Ruler',
      length: bounds.rect.width + xRulerExtension,
      majorInterval: 500,
      minorInterval: 100,
      majorTickHeight: 20,
      minorTickHeight: 10,
      leadIn: 30
    })

    xRuler.render(xRulerGroup)

    const mainGroup = new Konva.Group({
      name: 'main group',
      x: yRulerWidth,
      y: xRulerHeight,
      width: bounds.rect.width,
      height: bounds.rect.height
    })

    this.groupsValue.forEach(g => {
      const unitGroup = new Konva.Group({
        x: g.x,
        y: g.y,
        name: g.name,
      })
      _groupRects(g.rects, unitGroup)
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

    const topLevelGroups = [xRulerGroup, mainGroup]
    topLevelGroups.forEach(group => layer.add(group))
  }

  disconnect() {
    this.stage.destroy()
  }
}
