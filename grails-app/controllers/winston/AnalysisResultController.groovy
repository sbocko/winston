package winston

import grails.plugin.springsecurity.annotation.Secured
import sk.upjs.winston.Role

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured([Role.ROLE_USER])
class AnalysisResultController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AnalysisResult.list(params), model:[analysisResultInstanceCount: AnalysisResult.count()]
    }

    def show(AnalysisResult analysisResultInstance) {
        redirect(controller: analysisResultInstance.class.getSimpleName(), action: "show", id: analysisResultInstance.id)
    }

    def create() {
        respond new AnalysisResult(params)
    }

    @Transactional
    def save(AnalysisResult analysisResultInstance) {
        if (analysisResultInstance == null) {
            notFound()
            return
        }

        if (analysisResultInstance.hasErrors()) {
            respond analysisResultInstance.errors, view:'create'
            return
        }

        analysisResultInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'analysisResult.label', default: 'AnalysisResult'), analysisResultInstance.id])
                redirect analysisResultInstance
            }
            '*' { respond analysisResultInstance, [status: CREATED] }
        }
    }

    def edit(AnalysisResult analysisResultInstance) {
        respond analysisResultInstance
    }

    @Transactional
    def update(AnalysisResult analysisResultInstance) {
        if (analysisResultInstance == null) {
            notFound()
            return
        }

        if (analysisResultInstance.hasErrors()) {
            respond analysisResultInstance.errors, view:'edit'
            return
        }

        analysisResultInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'AnalysisResult.label', default: 'AnalysisResult'), analysisResultInstance.id])
                redirect analysisResultInstance
            }
            '*'{ respond analysisResultInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(AnalysisResult analysisResultInstance) {

        if (analysisResultInstance == null) {
            notFound()
            return
        }

        analysisResultInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'AnalysisResult.label', default: 'AnalysisResult'), analysisResultInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'analysisResult.label', default: 'AnalysisResult'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
