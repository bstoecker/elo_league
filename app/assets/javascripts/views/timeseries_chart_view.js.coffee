EloLeague.TimeseriesChartView = Ember.View.extend
  tagName: 'div'
  classNames: ['time-series-chart']

  min_tick_interval: { minutes: 60*1000, day: 24*60*60*1000, week: 7*24*60*60*1000, month: 7*24*60*60*1000 }
  colors: { volume: '#4572A7', volume_hist: '#9d9dbb', aht: '#D90000', aht_hist: '#D98080'}
  volume_name: I18n.t('annotation.workload.value_type.volume')
  aht_name: I18n.t('annotation.workload.value_type.aht')


  graphOptions: ->
    chart:
      type: 'line'
      plotBorderWidth: 1
      marginTop:       10
      marginLeft:      0
      marginRight:     0

    tooltip: 
      crosshairs: true
      shared: true
      useHTML: true

    credits:
      enabled: false

    title: ''

    rangeSelector: { enabled: false }

    plotOptions:
      line:
        gapSize: 2

    xAxis: @configXAxis()

    yAxis: [
      @configYAxis(@get('volume_name'), @get('colors.volume'), false, -10, @get('minVolume')),
      @configYAxis(@get('aht_name'), @get('colors.aht'), true, 30, @get('minAht'))
    ]

    navigator:
      xAxis: @configXAxis()
      margin: 40
      series: { data: @get('navigatorData') }

    series: [
      @configSeries(@get('volume_name'), 'volume_historic',  @get('colors.volume_hist'), 0, @get('volumeDataHistoric'))
      @configSeries(@get('volume_name'), 'volume_forecast',  @get('colors.volume'), 0, @get('volumeDataForecast'))
      @configSeries(@get('aht_name'), 'aht_historic',  @get('colors.aht_hist'), 1, @get('ahtDataHistoric'))
      @configSeries(@get('aht_name'), 'aht_forecast',  @get('colors.aht'), 1, @get('ahtDataForecast'))
    ]


  configSeries: (name, id, color, yaxis, data) ->
    {
      name:         name,
      id:           id,
      color:        color,
      tooltip:      { valueDecimals: 2 },
      dataGrouping: { enabled: false },
      yAxis:        yaxis,
      data:         data
    }

  configXAxis: ->
    {
      plotLines: [
        @configPlotLines(moment().toDate(), 'red', false),
        @configPlotLines(@get('lastHistTimestampVolume'), @get('colors.volume_hist'), true),
        @configPlotLines(@get('lastHistTimestampAht'), @get('colors.aht_hist'), true)
      ]
      type: 'datetime'
      ordinal: false
      minTickInterval: @get("min_tick_interval.#{@get('intervalUnit')}") * @get('intervalLength')
      dateTimeLabelFormats:
        second: I18n.t('date.highcharts.second')
        minute: I18n.t('date.highcharts.hour')
        hour: I18n.t('date.highcharts.hour')
        day: I18n.t('date.highcharts.day')
        week: I18n.t('date.highcharts.day')
        month: I18n.t('date.time_format.month')
        year: I18n.t('date.time_format.year')
      min: @get('extremes.first').getTime()
      max: @get('extremes.last').getTime()
    }

  configYAxis: (name, color, is_opposite, offset, min) ->
    {
      labels: {
        style: { color: color }
      },
      title: {
        text: name,
        align: 'high',
        margin: 10,
        offset: offset,
        rotation: '0',
        y: 15,
        style: { color: color }
      },
      offset: -40,
      opposite: is_opposite,
      min: min
    }



  configPlotLines: (value, color, history_marker)->
    if history_marker
      text = "<i class='fa fa-long-arrow-left'/><span> #{I18n.t('annotation.time_series.history')}</span>"
    else
      text = "<i class='fa fa-clock-o'/>"
    {
      value:     value
      dashStyle: 'Dash'
      color:     color
      width:     2
      label:
        align: 'right'
        y: 16
        x: -5
        rotation: 0
        useHTML: true
        text: text
        style: { color: color }
    }
  
  didInsertElement: ->
    @$().highcharts 'StockChart', @graphOptions()
    @set('controller.dataChart', @$().highcharts())




