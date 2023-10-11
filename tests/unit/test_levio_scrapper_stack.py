import aws_cdk as core
import aws_cdk.assertions as assertions

from levio_scrapper.levio_scrapper_stack import LevioScrapperStack

# example tests. To run these tests, uncomment this file along with the example
# resource in levio_scrapper/levio_scrapper_stack.py
def test_sqs_queue_created():
    app = core.App()
    stack = LevioScrapperStack(app, "levio-scrapper")
    template = assertions.Template.from_stack(stack)

#     template.has_resource_properties("AWS::SQS::Queue", {
#         "VisibilityTimeout": 300
#     })
