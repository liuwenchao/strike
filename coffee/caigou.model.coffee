$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'
Zhibiao = require 'zhibiao'

Model = ->
  model =
    id: ko.observable()
    price: ko.observable(0)
    content: ko.observable()
    weight: ko.observable()
    rezhi: ko.observable()
    company_name: ko.observable()
    pinming: ko.observable()
    addtime: ko.observable()
    staff: ko.observable()
    tel: ko.observable()
    address: ko.observable()
    status: ko.observable()
    progress: ko.observable()
    dwfrl_cell: ko.observable()
    dwfrl_u10_value: ko.observable()
    dwfrl_u20_value: ko.observable()
    dwfrl_unit: ko.observable()
    fyhqd_cell: ko.observable()
    fyhqd_unit: ko.observable()
    fyhqd_value: ko.observable()
    ganguo_cell: ko.observable()
    ganguo_unit: ko.observable()
    ganguo_value: ko.observable()
    gdt_cell: ko.observable()
    gdt_unit: ko.observable()
    gdt_value: ko.observable()
    gwfrl_cell: ko.observable()
    gwfrl_u10_value: ko.observable()
    gwfrl_u20_value: ko.observable()
    gwfrl_unit: ko.observable()
    hf_cell: ko.observable()
    hf_unit: ko.observable()
    hf_value: ko.observable()
    hff_cell: ko.observable()
    hff_unit: ko.observable()
    hff_value: ko.observable()
    hits: ko.observable()
    hrd_cell: ko.observable()
    hrd_unit: ko.observable()
    hrd_value: ko.observable()
    hskmzs_cell: ko.observable()
    hskmzs_unit: ko.observable()
    hskmzs_value: ko.observable()
    jiaoge_address: ko.observable()
    jiaoge_date: ko.observable()
    jiaoge_weight: ko.observable()
    jsldd_cell: ko.observable()
    jsldd_unit: ko.observable()
    jsldd_value: ko.observable()
    jtfyx_cell: ko.observable()
    jtfyx_unit: ko.observable()
    jtfyx_value: ko.observable()
    jzchd_cell: ko.observable()
    jzchd_unit: ko.observable()
    jzchd_value: ko.observable()
    jztz_cell: ko.observable()
    jztz_unit: ko.observable()
    jztz_value: ko.observable()
    ksqd_cell: ko.observable()
    ksqd_unit: ko.observable()
    ksqd_value: ko.observable()
    lidu_cell: ko.observable()
    lidu_unit: ko.observable()
    lidu_value_max: ko.observable()
    lidu_value_min: ko.observable()
    linfen_cell: ko.observable()
    linfen_unit: ko.observable()
    linfen_value: ko.observable()
    njzs_cell: ko.observable()
    njzs_unit: ko.observable()
    njzs_value: ko.observable()
    nmqd_cell: ko.observable()
    nmqd_unit: ko.observable()
    nmqd_value: ko.observable()
    ns_cell: ko.observable()
    ns_unit: ko.observable()
    ns_value: ko.observable()
    operate_staff_id: ko.observable()
    pay_address_one: ko.observable()
    pay_address_three: ko.observable()
    pay_address_two: ko.observable()
    pay_price: ko.observable()
    pay_type: ko.observable()
    pinming_one: ko.observable()
    pinming_two: ko.observable()
    qlf_cell: ko.observable()
    qlf_unit: ko.observable()
    qlf_value: ko.observable()
    qsf_cell: ko.observable()
    qsf_unit: ko.observable()
    qsf_value: ko.observable()

  model.main_zhibiao = ko.pureComputed ->
    switch model.pinming_one()
      when 1 then model.rezhi() + 'kcal'
      when 2 then model.rezhi() + 'kcal'
      when 3 then model.rezhi() + 'kcal'
      else model.rezhi() + 'kcal'

  model.status = ko.pureComputed ->
    switch model.progress()
      when '10000' then '未过滤'
      when '20000' then '已过滤'
      when '30000' then '已生成标准单'
      when '40000' then '已生成标准单'
      when '50000' then '已报价标准单'
      when '60000' then '已报价标准单'
      when '70000' then '已下单'
      when '90000' then '已完成'

  model.all_zhibiao = ko.pureComputed ->
    results = []
    if model.qsf_value() then results.push
      name: '全水分（Mt)'
      value: model.qsf_value()
    if model.dwfrl_u10_value()  then results.push
      name: '低位发热量(kcal)'
      value: model.dwfrl_u10_value()
    if model.hff_value()  then results.push
      name: '挥发份(%)'
      value: model.hff_value()
    if model.qlf_value()  then results.push
      name: '硫分(%)'
      value: model.qlf_value()
    if model.hrd_value()  then results.push
      name: '灰熔点(℃)'
      value: model.hrd_value()
    if model.njzs_value()  then results.push
      name: 'G值'
      value: model.njzs_value()
    if model.jzchd_value()  then results.push
      name: 'Y值'
      value: model.jzchd_value()
    # if model.ganguo_value() then results.push
    #   name: '坩埚/自由膨胀序数(CSN/FSI)'
    #   value: model.ganguo_value()
    # if model.hskmzs_value() then results.push
    #   name: '哈氏可磨(HGI)'
    #   value: model.hskmzs_value()
    # if model.lidu_value_min() then results.push
    #   name: '粒度(MM)'
    #   value: model.lidu_value_min()
    # if model.gdt_value() then results.push
    #   name: '固定碳(FC)'
    #   value: model.gdt_value()
    # if model.jztz_value() then results.push
    #   name: '焦渣特性(CRC)'
    #   value: model.jztz_value()
    # if model.ksqd_value() then results.push
    #   name: '抗碎强度(M40/M25)'
    #   value: model.ksqd_value()
    # if model.nmqd_value() then results.push
    #   name: '耐磨强度(M10)'
    #   value: model.nmqd_value()
    # if model.fyhqd_value() then results.push
    #   name: '反应后强度(CSR)'
    #   value: model.fyhqd_value()
    # if model.jtfyx_value() then results.push
    #   name: '焦炭反应性'
    #   value: model.jtfyx_value()
    results
  return model

fill = (data, model) ->
  model = new Model() if not model
  model.id data.caigou_id
  model.content data.content
  model.price data.standard_price_money || data.caigou?.pay_price || 0
  model.weight data.standard_ton || data.caigou?.pay_weight
  model.rezhi data.standard_div_content?.rezhi_value
  model.company_name data.member?.company?.name
  model.pinming data.variety[0]?.cate_name
  model.addtime data.created_time
  model.staff data.operate_staff?.name || ''
  model.tel data.operate_staff?.staff_mobile
  model.address data.standard_address
  model.progress data.progress || data.caigou?.progress
  model.dwfrl_cell data.standard_div_content?.dwfrl_cell
  model.dwfrl_u10_value data.standard_div_content?.dwfrl_u10_value
  model.dwfrl_u20_value data.standard_div_content?.dwfrl_u20_value
  model.dwfrl_unit data.standard_div_content?.dwfrl_unit
  model.fyhqd_cell data.standard_div_content?.fyhqd_cell
  model.fyhqd_unit data.standard_div_content?.fyhqd_unit
  model.fyhqd_value data.standard_div_content?.fyhqd_value
  model.ganguo_cell data.standard_div_content?.ganguo_cell
  model.ganguo_unit data.standard_div_content?.ganguo_unit
  model.ganguo_value data.standard_div_content?.ganguo_value
  model.gdt_cell data.standard_div_content?.gdt_cell
  model.gdt_unit data.standard_div_content?.gdt_unit
  model.gdt_value data.standard_div_content?.gdt_value
  model.gwfrl_cell data.standard_div_content?.gwfrl_cell
  model.gwfrl_u10_value data.standard_div_content?.gwfrl_u10_value
  model.gwfrl_u20_value data.standard_div_content?.gwfrl_u20_value
  model.gwfrl_unit data.standard_div_content?.gwfrl_unit
  model.hf_cell data.standard_div_content?.hf_cell
  model.hf_unit data.standard_div_content?.hf_unit
  model.hf_value data.standard_div_content?.hf_value
  model.hff_cell data.standard_div_content?.hff_cell
  model.hff_unit data.standard_div_content?.hff_unit
  model.hff_value data.standard_div_content?.hff_value
  model.hits data.standard_div_content?.hits
  model.hrd_cell data.standard_div_content?.hrd_cell
  model.hrd_unit data.standard_div_content?.hrd_unit
  model.hrd_value data.standard_div_content?.hrd_value
  model.hskmzs_cell data.standard_div_content?.hskmzs_cell
  model.hskmzs_unit data.standard_div_content?.hskmzs_unit
  model.hskmzs_value data.standard_div_content?.hskmzs_value
  model.jiaoge_address data.standard_div_content?.jiaoge_address
  model.jiaoge_date data.standard_div_content?.jiaoge_date
  model.jiaoge_weight data.standard_div_content?.jiaoge_weight
  model.jsldd_cell data.standard_div_content?.jsldd_cell
  model.jsldd_unit data.standard_div_content?.jsldd_unit
  model.jsldd_value data.standard_div_content?.jsldd_value
  model.jtfyx_cell data.standard_div_content?.jtfyx_cell
  model.jtfyx_unit data.standard_div_content?.jtfyx_unit
  model.jtfyx_value data.standard_div_content?.jtfyx_value
  model.jzchd_cell data.standard_div_content?.jzchd_cell
  model.jzchd_unit data.standard_div_content?.jzchd_unit
  model.jzchd_value data.standard_div_content?.jzchd_value
  model.jztz_cell data.standard_div_content?.jztz_cell
  model.jztz_unit data.standard_div_content?.jztz_unit
  model.jztz_value data.standard_div_content?.jztz_value
  model.ksqd_cell data.standard_div_content?.ksqd_cell
  model.ksqd_unit data.standard_div_content?.ksqd_unit
  model.ksqd_value data.standard_div_content?.ksqd_value
  model.lidu_cell data.standard_div_content?.lidu_cell
  model.lidu_unit data.standard_div_content?.lidu_unit
  model.lidu_value_max data.standard_div_content?.lidu_value_max
  model.lidu_value_min data.standard_div_content?.lidu_value_min
  model.linfen_cell data.standard_div_content?.linfen_cell
  model.linfen_unit data.standard_div_content?.linfen_unit
  model.linfen_value data.standard_div_content?.linfen_value
  model.njzs_cell data.standard_div_content?.njzs_cell
  model.njzs_unit data.standard_div_content?.njzs_unit
  model.njzs_value data.standard_div_content?.njzs_value
  model.nmqd_cell data.standard_div_content?.nmqd_cell
  model.nmqd_unit data.standard_div_content?.nmqd_unit
  model.nmqd_value data.standard_div_content?.nmqd_value
  model.ns_cell data.standard_div_content?.ns_cell
  model.ns_unit data.standard_div_content?.ns_unit
  model.ns_value data.standard_div_content?.ns_value
  model.operate_staff_id data.standard_div_content?.operate_staff_id
  model.pay_address_one data.standard_div_content?.pay_address_one
  model.pay_address_three data.standard_div_content?.pay_address_three
  model.pay_address_two data.standard_div_content?.pay_address_two
  model.pay_price data.standard_div_content?.pay_price
  model.pay_type data.standard_div_content?.pay_type
  model.pinming_one data.standard_div_content?.pinming_one
  model.pinming_two data.standard_div_content?.pinming_two
  model.qlf_cell data.standard_div_content?.qlf_cell
  model.qlf_unit data.standard_div_content?.qlf_unit
  model.qlf_value data.standard_div_content?.qlf_value
  model.qsf_cell data.standard_div_content?.qsf_cell
  model.qsf_unit data.standard_div_content?.qsf_unit
  model.qsf_value data.standard_div_content?.qsf_value
  model

module.exports =
  Model:  Model
  fill:   fill
