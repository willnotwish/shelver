import Konva from 'konva'

class Ruler extends Konva.Group {
  constructor(options) {
    super(options)
    
    this.orientation = options.orientation || 'horizontal'
    this.length = options.length || 1000
    this.majorInterval = options.majorInterval
    this.minorInterval = options.minorInterval
    this.majorTickLength = options.majorTickLength
    this.minorTickHeight = options.minorTickHeight
    this.labelFontSize = options.labelFontSize || 28
    this.outline = options.outline
    this.strokeColour = options.lineColour || 'grey'
    this.leadIn = options.leadIn || 20

    this.render(this)
  }

  get horizontal() {
    return this.orientation == 'horizontal'
  }

  get vertical() {
    return this.orientation == 'vertical'
  }

  width() {
    if (this.horizontal) {
      return this.length
    } 
    
    return this.majorTickLength
  }

  height() {
    if (this.horizontal) {
      return this.majorTickLength
    }

    return this.length
  }

  render(parent) {
    if (this.outline) {
      this.renderOutline(parent)
    }

    // Axis (line)
    const axisOptions = {
      stroke: this.strokeColour,
      strokeWidth: 4,
    }

    const axis = _axis({leadIn: this.leadIn, extent: this.length, horizontal: this.horizontal})
    parent.add(new Konva.Line({...axisOptions, ...axis}))

    // Tick marks
    const tickOptions = {
      stroke: this.strokeColour,
      strokeWidth: 4,
    }

    const posMax = this.length
    let posMajor = 0
    while (posMajor <= posMax) {
      const majorTick = _tick({pos: posMajor, length: this.majorTickLength, horizontal: this.horizontal})
      parent.add(new Konva.Line({...tickOptions, ...majorTick}))

      // Label (value)
      let label
      const text = posMajor

      if (this.horizontal) {
        label = new Konva.Text({
          x: posMajor,
          text,
          fontSize: this.labelFontSize,
        })
        label.offsetX(label.width() / 2)
        label.offsetY(1.5 * label.height())
      } else {
        label = new Konva.Text({
          y: posMajor, 
          text,
          fontSize: this.labelFontSize,
        })
        const halfHeight = label.height() / 2
        label.offsetX(label.width() + halfHeight)
        label.offsetY(halfHeight)
      }

      parent.add(label)

      // Minor ticks
      let posMinor = 0
      while (posMinor < this.majorInterval) {
        const pos = posMajor + posMinor
        if (pos > posMax) {
          break
        }
        
        const minorTick = _tick({pos, length:this.minorTickHeight, horizontal: this.horizontal})
        parent.add(new Konva.Line({...tickOptions, ...minorTick}))
        
        posMinor += this.minorInterval
      }

      posMajor += this.majorInterval
    }
  }

  renderOutline(parent) {
    const rect = new Konva.Rect({
      width: this.width(),
      height: this.height(),
      stroke: 'black',
      dash: [4, 4]
    })
    return parent.add(rect)
  }
}

function _tick({pos, length, horizontal}) {
  if (horizontal) {
    return { points: [0, 0, 0, length], offsetX: -pos }
  } 
  
  return {points: [0, 0, length, 0], offsetY: -pos}
}

function _axis({leadIn, extent, horizontal}) {
  let points
  if (horizontal) {
    points = [-leadIn, 0, extent, 0]
  } else {
    points = [0, -leadIn, 0, extent]
  }

  return { points }
}

export default Ruler
