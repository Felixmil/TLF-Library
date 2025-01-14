#' @title TimeProfilePlotConfiguration
#' @description R6 class defining the configuration of a `ggplot` object for time profile plots
#' @export
#' @family PlotConfiguration classes
TimeProfilePlotConfiguration <- R6::R6Class(
  "TimeProfilePlotConfiguration",
  inherit = PlotConfiguration,
  public = list(
    #' @description Create a new `TimeProfilePlotConfiguration` object
    #' @param y2label character or `Label` object defining plot y2label
    #' @param y2Axis `YAxisConfiguration` object defining y-axis properties
    #' @param y2Scale name of y2-axis scale. Use enum `Scaling` to access predefined scales.
    #' @param y2Limits numeric vector of length 2 defining y-axis limits
    #' @param data data.frame used by `.smartMapping`
    #' @param metaData list of information on `data`
    #' @param dataMapping R6 class or subclass `TimeProfileDataMapping`
    #' @param ... parameters inherited from `PlotConfiguration`
    #' @return A new `TimeProfilePlotConfiguration` object
    initialize = function(...,
                          # Y2 label
                          y2label = NULL,
                          # Y2-Axis configuration
                          y2Axis = NULL,
                          y2Scale = NULL,
                          y2Limits = NULL,
                          # Smart configuration using metaData
                          data = NULL,
                          metaData = NULL,
                          dataMapping = NULL) {
      super$initialize(
        ..., 
        data = data,
        metaData = metaData,
        dataMapping = dataMapping
        )
      # Update Y2 label
      private$.labels$y2label <- y2label %||% private$.labels$y2label
      if (!is.null(data)) {
        dataMapping <- dataMapping %||% TimeProfileDataMapping$new(data = data)
      }
      private$.labels$y2label <- asLabel(
        y2label %||%
          .dataMappingLabel(dataMapping$y2Axis, metaData) %||%
          dataMapping$y2Axis %||%
          private$.labels$y2label$text, font = private$.labels$y2label$font
      )
      
      # Y2-Axis configuration, overwrite some properties only if they are defined
      validateIsOfType(y2Axis, "YAxisConfiguration", nullAllowed = TRUE)
      private$.y2Axis <- y2Axis %||% YAxisConfiguration$new(
        scale = self$defaultYScale,
        expand = self$defaultExpand
      )
      private$.y2Axis$position <- "right"
      private$.y2Axis$limits <- y2Limits %||% private$.y2Axis$limits
      private$.y2Axis$scale <- y2Scale %||% private$.y2Axis$scale
    }
  ),
  active = list(
    #' @field y2Axis `YAxisConfiguration` object defining properties of y2-axis
    y2Axis = function(value) {
      if (missing(value)) {
        return(private$.y2Axis)
      }
      validateIsOfType(value, "YAxisConfiguration", nullAllowed = TRUE)
      private$.y2Axis <- value %||% private$.y2Axis
      private$.y2Axis$position <- "right"
      return(invisible())
    }
  ),
  private = list(
    .y2Axis = NULL
  )
)
