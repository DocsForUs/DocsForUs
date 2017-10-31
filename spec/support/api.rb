# {
#   "meta": {
#     "data_type": "array",
#     "item_type": "Doctor",
#     "total": 1,
#     "count": 1,
#     "skip": 0,
#     "limit": 10
#   },
#   "data": [
#     {
#       "practices": [
#         {
#           "uid": "gdrjhdfggrhlkghlughulrhgiulshuligthlurt",
#           "visit_address": {
#             "city": "Seattle",
#             "state": "WA",
#             "street": "555 Doctor Pl",
#             "zip": "98103"
#           },
#           "phones": [
#             {
#               "number": "2065559999",
#               "type": "landline"
#             }
#           ]
#         }
#       ],
#       "profile": {
#         "first_name": "Laura ",
#         "last_name": "Spring",
#         "title": "MD",
#         "gender": "female",
#         "insurances": [
#           {
#             "insurance_plan": {
#               "uid": "insurance-insurance",
#               "name": "Some insurance",
#               "category": [
#                 "medical"
#               ]
#             },
#             "insurance_provider": {
#               "uid": "otherinsurance",
#               "name": "Other Insurance"
#             }
#           }
#         ],
#         "specialties": [
#           {
#             "name": "Family Medicine"
#           }
#         ],
#         "uid": "ewrwewrewrew"
#       }
#     }
#   ]
# }
def faked_doctor_search
  {:meta=>{:data_type=>"array", :item_type=>"Doctor", :total=>1, :count=>1, :skip=>0, :limit=>10}, :data=>[{:practices=>[{:uid=>"gdrjhdfggrhlkghlughulrhgiulshuligthlurt", :visit_address=>{:city=>"Seattle", :state=>"WA", :street=>"555 Doctor Pl", :zip=>"98103"}, :phones=>[{:number=>"2065559999", :type=>"landline"}]}], :profile=>{:first_name=>"Laura ", :last_name=>"Spring", :title=>"MD", :gender=>"female", :insurances=>[{:insurance_plan=>{:uid=>"insurance-insurance", :name=>"Some insurance", :category=>["medical"]}, :insurance_provider=>{:uid=>"otherinsurance", :name=>"Other Insurance"}}], :specialties=>[{:name=>"Family Medicine"}], :uid=>"ewrwewrewrew"}}]}
end
