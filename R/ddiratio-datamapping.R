#' @title DDIRatioDataMapping
#' @description  R6 class for mapping `x`, `y`, `GroupMapping` and DDI ratio `lines` variables to `data`
#' @export
#' @family DataMapping classes
DDIRatioDataMapping <- R6::R6Class(
  "DDIRatioDataMapping",
  inherit = PKRatioDataMapping,
  public = list(
    #' @field minRange Mininmum range for guest and ratio lines
    minRange = NULL,
    #' @field deltaGuest Value of `delta` in Guest et al. equation
    deltaGuest = NULL,
    #' @field residualsVsObserved if true, returns a mapping for generating a residuals (predicted/observed) vs observed DDI ratio plot.  If false (default) returns a mapping for predicted vs observed DDI ratio plot.
    residualsVsObserved = NULL,

    #' @description Create a new `DDIRatioDataMapping` object
    #' @param deltaGuest Value of parameter `delta` in Guest et al. equation.
    #' Default value is 1.
    #' @param minRange Mininmum range for guest lines
    #' @param lines List of ratio limits to display as diagonal/horizontal lines
    #' @param residualsVsObserved if true, returns a mapping for generating a residuals (predicted/observed) vs observed DDI ratio plot.  If false (default) returns a mapping for predicted vs observed DDI ratio plot.
    #' @param ... parameters inherited from \code{PKRatioDataMapping}
    #' @return A new \code{DDIRatioDataMapping} object
    initialize = function(deltaGuest = 1,
                          minRange = c(1e-2, 1e2),
                          lines = DefaultDataMappingValues$ddiRatio,
                          residualsVsObserved = FALSE,
                          ...) {
      super$initialize(...)
      validateIsNumeric(deltaGuest)
      validateIsNumeric(minRange)
      validateIsOfLength(minRange, 2)
      validateIsLogical(residualsVsObserved)

      self$lines <- lines
      self$minRange <- minRange
      self$deltaGuest <- deltaGuest
      self$residualsVsObserved <- residualsVsObserved
    }
  )
)
