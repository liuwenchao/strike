$ = require 'jquery'
ko = require 'knockout'
parameters = require 'parameters'
Zhibiao = require 'zhibiao'

Model = ->
  model =
    id: ko.observable()
    pinming: ko.observable()
    price: ko.observable()
    weight: ko.observable()
    rezhi: ko.observable()
    isqihuo: ko.observable()
    address: ko.observable('')
    addtime: ko.observable(new Date())
    company_name: ko.observable('')
    member_name: ko.observable()
    member_title: ko.observable()
    telephone: ko.observable()
    mobile: ko.observable()
    zhibiao_more: ko.observable()
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
    progress: ko.observable()
    paihao: ko.observable()
    cangku: ko.observable()

  model.main_zhibiao = ko.pureComputed ->
    switch model.pinming_one()
      when 1 then model.rezhi() + 'kcal'
      when 2 then model.rezhi() + 'kcal'
      when 3 then model.rezhi() + 'kcal'
      else model.rezhi() + 'kcal'

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
    if model.ganguo_value() then results.push
      name: '坩埚/自由膨胀序数(CSN/FSI)'
      value: model.ganguo_value()
    if model.hskmzs_value() then results.push
      name: '哈氏可磨(HGI)'
      value: model.hskmzs_value()
    if model.lidu_value_min() then results.push
      name: '粒度(MM)'
      value: model.lidu_value_min()
    if model.gdt_value() then results.push
      name: '固定碳(FC)'
      value: model.gdt_value()
    if model.jztz_value() then results.push
      name: '焦渣特性(CRC)'
      value: model.jztz_value()
    if model.ksqd_value() then results.push
      name: '抗碎强度(M40/M25)'
      value: model.ksqd_value()
    if model.nmqd_value() then results.push
      name: '耐磨强度(M10)'
      value: model.nmqd_value()
    if model.fyhqd_value() then results.push
      name: '反应后强度(CSR)'
      value: model.fyhqd_value()
    if model.jtfyx_value() then results.push
      name: '焦炭反应性'
      value: model.jtfyx_value()
    results
  return model

fill = (data, model) ->
  model = new Model() if not model
  model.id  data.id
  model.pinming data.variety[0]?.cate_name
  model.paihao data.paihao
  model.price data.pay_price
  model.weight data.jg_weight
  model.rezhi data.dwfrl_ar
  model.isqihuo data.supply_type == 2
  model.address data.jg_address_info || ''
  model.addtime new Date data.created_time
  model.company_name data.member?.company?.name || ''
  model.member_name data.member?.truename
  model.member_title data.member?.job
  model.telephone data.member?.telephone
  model.mobile data.member?.mobile
  model.zhibiao_more data.zhibiao_more
  model.dwfrl_cell data.dwfrl_cell
  model.dwfrl_u10_value data.dwfrl_u10_value
  model.dwfrl_u20_value data.dwfrl_u20_value
  model.dwfrl_unit data.dwfrl_unit
  model.fyhqd_cell data.fyhqd_cell
  model.fyhqd_unit data.fyhqd_unit
  model.fyhqd_value data.fyhqd
  model.ganguo_cell data.ganguo_cell
  model.ganguo_unit data.ganguo_unit
  model.ganguo_value data.ganguo
  model.gdt_cell data.gdt_cell
  model.gdt_unit data.gdt_unit
  model.gdt_value data.gdt_ar
  model.gwfrl_cell data.gwfrl_cell
  model.gwfrl_u10_value data.gwfrl_u10_value
  model.gwfrl_u20_value data.gwfrl_u20_value
  model.gwfrl_unit data.gwfrl_unit
  model.hf_cell data.hf_cell
  model.hf_unit data.hf_unit
  model.hf_value data.hf_ar
  model.hff_cell data.hff_cell
  model.hff_unit data.hff_unit
  model.hff_value data.hff_ar
  model.hits data.hits
  model.hrd_cell data.hrd_cell
  model.hrd_unit data.hrd_unit
  model.hrd_value data.hrd
  model.hskmzs_cell data.hskmzs_cell
  model.hskmzs_unit data.hskmzs_unit
  model.hskmzs_value data.hskmzs
  model.jiaoge_address data.jg_address_info
  model.jiaoge_date data.jiaoge_date
  model.jiaoge_weight data.jg_weight
  model.jsldd_cell data.jsldd_cell
  model.jsldd_unit data.jsldd_unit
  model.jsldd_value data.jsldd_value
  model.jtfyx_cell data.jtfyx_cell
  model.jtfyx_unit data.jtfyx_unit
  model.jtfyx_value data.jtfyx
  model.jzchd_cell data.jzchd_cell
  model.jzchd_unit data.jzchd_unit
  model.jzchd_value data.jzchd_value
  model.jztz_cell data.jztz_cell
  model.jztz_unit data.jztz_unit
  model.jztz_value data.jztz
  model.ksqd_cell data.ksqd_cell
  model.ksqd_unit data.ksqd_unit
  model.ksqd_value data.ksqd_value
  model.lidu_cell data.lidu_cell
  model.lidu_unit data.lidu_unit
  model.lidu_value_max data.lidu_max
  model.lidu_value_min data.lidu_min
  model.linfen_cell data.linfen_cell
  model.linfen_unit data.linfen_unit
  model.linfen_value data.linfen_value
  model.njzs_cell data.njzs_cell
  model.njzs_unit data.njzs_unit
  model.njzs_value data.njzs
  model.nmqd_cell data.nmqd_cell
  model.nmqd_unit data.nmqd_unit
  model.nmqd_value data.nmqd
  model.ns_cell data.ns_cell
  model.ns_unit data.ns_unit
  model.ns_value data.ns_value
  model.operate_staff_id data.operate_staff_id
  model.pay_address_one data.pay_address_one
  model.pay_address_three data.pay_address_three
  model.pay_address_two data.pay_address_two
  model.pay_price data.pay_price
  model.pay_type data.pay_type
  model.pinming_one data.pinming_one
  model.pinming_two data.pinming_two
  model.qlf_cell data.qlf_cell
  model.qlf_unit data.qlf_unit
  model.qlf_value data.qlf_ar
  model.qsf_cell data.qsf_cell
  model.qsf_unit data.qsf_unit
  model.qsf_value data.qsf
  model.progress data.progress
  model

module.exports =
  Model:  Model
  fill:   fill
